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

package sharedvpc

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestFoundationSharedVPC(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			networkName := net.GetStringOutput("network_name")

			// VPC
			vpc := gcloud.Runf(t, "compute networks describe %s --project %s", networkName, projectID)
			assert.Equal("servicenetworking-googleapis-com", vpc.Get("peerings.0.name").String(), "should have service networking configured")
			sub_nets := gcloud.Runf(t, "compute networks subnets list %s --project %s", networkName, projectID).Array()
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

			assert.Empty(gcloud.Runf(t, "compute shared-vpc list-associated-resources %s", projectID).Array(), fmt.Sprintf("%s should be a shared VPC Host project", projectID))

			// NCC
			nccHubName := net.GetStringOutput("ncc_hub_name")
			op := gcloud.Runf(t, "network-connectivity hubs describe %s --project %s", nccHubName, projectID)
			meshPresetTopology := op.Get("presetTopology").String()
			assert.Equal("MESH", meshPresetTopology, "should have mesh topology")
			nccSpokeStateCount := op.Get("spokeSummary.spokeStateCounts").Array()
			assert.Equal(1, len(nccSpokeStateCount), "should have spokes in one State")
			assert.Equal("ACTIVE", nccSpokeStateCount[0].Get("state").String(), "should have only active spokes")
			assert.Equal("2", nccSpokeStateCount[0].Get("count").String(), "should have two active spokes")

			groups := gcloud.Runf(t, "network-connectivity hubs groups list --hub %s --project %s", nccHubName, projectID).Array()
			assert.Equal(1, len(groups), "should have one group")
			assert.Equal("ACTIVE", groups[0].Get("state").String(), "should have active group")
			assert.Equal(projectID, groups[0].Get("autoAccept.autoAcceptProjects.0").String(), "%s should be on auto accept", projectID)
			groupName := fmt.Sprintf("projects/%s/locations/global/hubs/%s/groups/default", projectID, nccHubName)
			assert.Equal(groupName, groups[0].Get("name").String(), "should have default group")

			// DNS
			dnsPolicies := gcloud.Runf(t, "dns policies list --project %s", projectID).Array()
			assert.Equal(1, len(dnsPolicies), "should have one DNS Policy")
			assert.Equal("ACTIVE", dnsPolicies[0].Get("state").String(), "should have active DNS Policy")
			assert.True(dnsPolicies[0].Get("enableLogging").Bool(), fmt.Sprintf("DNS Policy %s should have logs enabled", dnsPolicies[0].Get("name").String()))

			for _, dnsName := range []string{
				"dz-c-svpc-gcr",
				"dz-c-svpc-apis",
				"dz-c-svpc-pkg-dev",
			} {

				dnsZone := gcloud.Runf(t, "dns managed-zones describe %s --project %s ", dnsName, projectID)
				assert.Equal(dnsName, dnsZone.Get("name").String(), fmt.Sprintf("dnsZone %s should exist", dnsName))
			}

			for _, recordSet := range []struct {
				name  string
				rtype string
				zone  string
			}{
				{
					name:  "*.gcr.io.",
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
					name:  "gcr.io.",
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
				record := gcloud.Runf(t, "dns record-sets describe '%s' --type=%s --zone=%s  --project %s ", recordSet.name, recordSet.rtype, recordSet.zone, projectID)
				assert.Equal(recordSet.name, record.Get("name").String(), fmt.Sprintf("record set %s should exist", recordSet.name))
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
					priority:  "*65530",
					direction: "EGRESS",
					action:    "deny",
				},
			} {
				r := gcloud.Runf(t, "compute network-firewall-policies rules describe %s --firewall-policy=%s --global-firewall-policy --project %s ", rule.priority, "fp-c-firewalls", projectID)
				assert.Equal(rule.direction, r.Get("direction").String(), fmt.Sprintf("rule with priority %s should be EGRESS", rule.priority))
				assert.Equal(rule.action, r.Get("action").String(), fmt.Sprintf("rule with priority %s should be allow", rule.priority))
			}
		})
	net.Test()
}
