// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package hubandspoke

import (
	"fmt"
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestFoundationHubAndSpoke(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectIDHub := net.GetStringOutput("project_id_hub")
			projectIDSpoke := net.GetStringOutput("project_id_spoke")
			hubNetworkName := net.GetStringOutput("hub_network_name")

			// VPC
			vpc := gcloud.Runf(t, "compute networks describe %s --project %s", hubNetworkName, projectIDHub)
			assert.Equal("servicenetworking-googleapis-com", vpc.Get("peerings.0.name").String(), "should have service networking configured")
			sub_nets := gcloud.Runf(t, "compute networks subnets list %s --project %s", hubNetworkName, projectIDHub).Array()
			assert.Equal(4, len(sub_nets), "should have four sub networks configured")
			private_sub_count := 0
			proxy_sub_count := 0
			for _, sub := range sub_nets {
				selfLink := sub.Get("selfLink").String()
				if sub.Get("purpose").String() == "PRIVATE" {
					private_sub_count = private_sub_count + 1
					assert.True(sub.Get("privateIpGoogleAccess").Bool(), fmt.Sprintf("private subnetwork %s should have private Google IP Access enabled", selfLink))
					assert.True(sub.Get("logConfig.enable").Bool(), fmt.Sprintf("private subnetwork %s should have VPC Logs enabled", selfLink))
				}
				if sub.Get("purpose").String() == "REGIONAL_MANAGED_PROXY" {
					proxy_sub_count = proxy_sub_count + 1
					assert.False(sub.Get("privateIpGoogleAccess").Bool(), fmt.Sprintf("proxy subnetwork %s should not have private Google IP Access enabled", selfLink))
					assert.False(sub.Get("logConfig.enable").Bool(), fmt.Sprintf("proxy subnetwork %s should not have VPC Logs enabled", selfLink))
				}
			}
			assert.Equal(2, private_sub_count, "should have two private sub networks configured")
			assert.Equal(2, proxy_sub_count, "should have two proxy sub networks configured")

			assert.Empty(gcloud.Runf(t, "compute shared-vpc list-associated-resources %s", projectIDHub).Array(), fmt.Sprintf("%s should be a shared VPC Host project", projectIDHub))

			// NCC
			nccHubURI := net.GetStringOutput("ncc_hub_uri")
			op := gcloud.Runf(t, "network-connectivity hubs describe %s --project %s", nccHubURI, projectIDHub)
			presetTopology := op.Get("presetTopology").String()
			assert.Equal("STAR", presetTopology, "should have star topology")
			nccSpokeStateCount := op.Get("spokeSummary.spokeStateCounts").Array()
			assert.Equal(1, len(nccSpokeStateCount), "should have spokes in one State")
			assert.Equal("ACTIVE", nccSpokeStateCount[0].Get("state").String(), "should have only active spokes")
			assert.Equal("2", nccSpokeStateCount[0].Get("count").String(), "should have two active spokes")

			groups := gcloud.Runf(t, "network-connectivity hubs groups list --hub %s --project %s", nccHubURI, projectIDHub).Array()
			assert.Equal(2, len(groups), "should have two group")
			//filter center group loop checking the name
			hasCenter := false
			hasEdge := false
			for _, group := range groups {
				assert.Equal("ACTIVE", group.Get("state").String(), "should have active group")

				n := strings.Split(group.Get("name").String(), "/")
				gName := n[len(n)-1]
				if gName == "center" {
					hasCenter = true
					assert.Equal(projectIDHub, group.Get("autoAccept.autoAcceptProjects.0").String(), "%s should be on auto accept", projectIDHub)
					fullGroupName := fmt.Sprintf("%s/groups/%s", nccHubURI, "center")
					assert.Equal(fullGroupName, group.Get("name").String(), "should have center group")
				}
				if gName == "edge" {
					hasEdge = true
					assert.Equal(projectIDHub, group.Get("autoAccept.autoAcceptProjects.0").String(), "%s should be on auto accept", projectIDSpoke)
					fullGroupName := fmt.Sprintf("%s/groups/%s", nccHubURI, "edge")
					assert.Equal(fullGroupName, group.Get("name").String(), "should have edge group")
				}
			}
			assert.True(hasCenter, "must have a centre group")
			assert.True(hasEdge, "must have a edge group")

			// DNS
			dnsPoliciesHub := gcloud.Runf(t, "dns policies list --project %s", projectIDHub).Array()
			assert.Equal(1, len(dnsPoliciesHub), "should have one DNS Policy")
			policyName := dnsPoliciesHub[0].Get("name").String()
			assert.True(dnsPoliciesHub[0].Get("enableLogging").Bool(), fmt.Sprintf("DNS Policy %s should have Logs enabled", policyName))
			assert.True(dnsPoliciesHub[0].Get("enableInboundForwarding").Bool(), fmt.Sprintf("DNS Policy %s should have Forwarding enabled", policyName))

			for _, dnsZoneName := range []string{
				"dz-h-svpc-gcr",
				"dz-h-svpc-apis",
				"dz-h-svpc-pkg-dev",
				"fz-h-dns-hub",
			} {

				dnsZone := gcloud.Runf(t, "dns managed-zones describe %s --project %s ", dnsZoneName, projectIDHub)
				assert.Equal(dnsZoneName, dnsZone.Get("name").String(), fmt.Sprintf("dnsZone %s should exist", dnsZoneName))
				if dnsZoneName == "fz-h-dns-hub" {
					assert.NotEmpty(dnsZone.Get("forwardingConfig.targetNameServers").Array(), fmt.Sprintf("dnsZone %s should have forwarding servers", dnsZoneName))
				}
			}

			for _, recordSet := range []struct {
				name  string
				rtype string
				zone  string
			}{
				{
					name:  "*.gcrHub.io.",
					rtype: "CNAME",
					zone:  "dz-c-svpc-gcr",
				},
				{
					name:  "*.googleapis.com.",
					rtype: "CNAME",
					zone:  "dz-c-svpc-apis",
				},
				{
					name:  "*.pkg.dev.",
					rtype: "CNAME",
					zone:  "dz-c-svpc-pkg-dev",
				},
				{
					name:  "gcrHub.io.",
					rtype: "A",
					zone:  "dz-c-svpc-gcr",
				},
				{
					name:  "restricted.googleapis.com.",
					rtype: "A",
					zone:  "dz-c-svpc-apis",
				},
				{
					name:  "pkg.dev.",
					rtype: "A",
					zone:  "dz-c-svpc-pkg-dev",
				},
			} {
				record := gcloud.Runf(t, "dns record-sets describe '%s' --type=%s --zone=%s  --project %s ", recordSet.name, recordSet.rtype, recordSet.zone, projectIDHub)
				assert.Equal(recordSet.name, record.Get("name").String(), fmt.Sprintf("record set %s should exist", recordSet.name))
			}

			// NAT configuration
			for _, region := range []string{
				"us-central1",
				"us-west1",
			} {
				r := gcloud.Runf(t, "compute routers list --regions %s --project %s ", region, projectIDHub)
				routerName := r.Get("name")
				assert.NotEmpty(r.Get("nats").Array(), fmt.Sprintf("router %s should have NAT configuration", routerName))
				assert.Equal(2, len(r.Get("nats.0.natIps").Array()), fmt.Sprintf("router %s should have two IPs", routerName))
				rNat := gcloud.Runf(t, "compute routers nats list --router %s --region %s --project %s ", routerName, region, projectIDHub).Array()
				assert.NotEmpty(rNat, fmt.Sprintf("Cloud NAT gateway for router %s should exist", routerName))
			}

			// Network firewall policy
			for _, rule := range []struct {
				priority  string
				direction string
				action    string
			}{
				{
					priority:  "1000",
					direction: "EGRESS",
					action:    "allow",
				},
				{
					priority:  "65530",
					direction: "EGRESS",
					action:    "deny",
				},
			} {
				rHub := gcloud.Runf(t, "compute network-firewall-policies rules describe %s --firewall-policy=%s --global-firewall-policy --project %s ", rule.priority, "fp-c-firewalls", projectIDHub).Array()[0]
				assert.Equal(rule.direction, rHub.Get("direction").String(), fmt.Sprintf("rule with priority %s should be EGRESS", rule.priority))
				assert.Equal(rule.action, rHub.Get("action").String(), fmt.Sprintf("rule with priority %s should be allow", rule.priority))
			}
		})
	net.Test()
}
