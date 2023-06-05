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

package regional_network_firewall_policy

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestRegionalNetworkFirewallPolicy(t *testing.T) {
	fwp := tft.NewTFBlueprintTest(t)
	fwp.DefineVerify(
		func(assert *assert.Assertions) {
			fwp.DefaultVerify(assert)
			projectID := fwp.GetStringOutput("project_id")
			policyName := fwp.GetStringOutput("firewall_policy_name")
			policyRegion := fwp.GetStringOutput("firewall_policy_region")

			policy := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies describe %s --region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range policy.Array() {
				assert.Equal(policyName, sp.Get("name").String(), "has expected name")
				assert.Equal("test regional firewall policy", sp.Get("description").String(), "has expected name")
			}

			rule1 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 1 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule1.Array() {
				assert.Equal("allow", sp.Get("action").String(), "Rule1 action should be allow")
				assert.Equal("ingress-1", sp.Get("ruleName").String(), "Rule1 ruleName should be ingress-1")
				assert.Equal("test ingres rule 1", sp.Get("description").String(), "Rule1 has expected description")
				assert.Equal("INGRESS", sp.Get("direction").String(), "Rule1 direction should be INGRESS")
				assert.False(sp.Get("disabled").Bool(), "Rule1 should be enabled")
				assert.True(sp.Get("enableLogging").Bool(), "Rule1 Logging should be enabled")
				assert.Equal("google.com", sp.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
				assert.Equal("10.100.0.1/32", sp.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("US", sp.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
				assert.Equal("all", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
				secureTags := sp.Get("match.srcSecureTags").Array()
				assert.Equal(1, len(secureTags), "should have the correct secure tag count")
			}

			rule2 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 2 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule2.Array() {
				assert.Equal("deny", sp.Get("action").String(), "Rule2 action should be deny")
				assert.Equal("ingress-2", sp.Get("ruleName").String(), "Rule2 ruleName should be ingress-2")
				assert.Equal("test ingres rule 2", sp.Get("description").String(), "Rule2 has expected description")
				assert.Equal("INGRESS", sp.Get("direction").String(), "Rule2 direction should be INGRESS")
				assert.True(sp.Get("disabled").Bool(), "Rule2 should be Disabled")
				assert.False(sp.Get("enableLogging").Bool(), "Rule2 Logging should be disabled")
				assert.Equal("google.org", sp.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
				assert.Equal("10.100.0.2/32", sp.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("BE", sp.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
				assert.Equal("all", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			}

			rule3 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 3 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule3.Array() {
				assert.Equal("allow", sp.Get("action").String(), "Rule3 action should be allow")
				assert.Equal("ingress-3", sp.Get("ruleName").String(), "Rule3 ruleName should be ingress-3")
				assert.Equal("test ingres rule 3", sp.Get("description").String(), "Rule3 has expected description")
				assert.Equal("INGRESS", sp.Get("direction").String(), "Rule3 direction should be INGRESS")
				assert.True(sp.Get("disabled").Bool(), "Rule3 should be disabled")
				assert.True(sp.Get("enableLogging").Bool(), "Rule3 Logging should be enabled")
				assert.Equal("10.100.0.3/32", sp.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("10.100.0.103/32", sp.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
				assert.Equal("tcp", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			}

			rule101 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 101 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule101.Array() {
				assert.Equal("allow", sp.Get("action").String(), "Rule101 action should be allow")
				assert.Equal("egress-101", sp.Get("ruleName").String(), "Rule101 ruleName should be ingress-1")
				assert.Equal("test egress rule 101", sp.Get("description").String(), "Rule101has expected description")
				assert.Equal("EGRESS", sp.Get("direction").String(), "Rule101 direction should be INGRESS")
				assert.False(sp.Get("disabled").Bool(), "Rule101 should be enabled")
				assert.True(sp.Get("enableLogging").Bool(), "Rule101 Logging should be enabled")
				assert.Equal("google.com", sp.Get("match.destFqdns").Array()[0].String(), "has expected destFqdns")
				assert.Equal("10.100.0.2/32", sp.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("US", sp.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
				assert.Equal("all", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
				destAddressGroups := sp.Get("match.destAddressGroups").Array()
				assert.Equal(1, len(destAddressGroups), "should have the correct destination address group count")
				assert.Equal("iplist-public-clouds", sp.Get("match.destThreatIntelligences").Array()[0].String(), "has expected srcIpRanges")
			}

			rule102 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 102 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule102.Array() {
				assert.Equal("deny", sp.Get("action").String(), "Rule102 action should be deny")
				assert.Equal("egress-102", sp.Get("ruleName").String(), "Rule102 ruleName should be ingress-1")
				assert.Equal("test egress rule 102", sp.Get("description").String(), "Rule102 has expected description")
				assert.Equal("EGRESS", sp.Get("direction").String(), "Rule102 direction should be INGRESS")
				assert.True(sp.Get("disabled").Bool(), "Rule102 should be disabled")
				assert.False(sp.Get("enableLogging").Bool(), "Rule102 Logging should be disabled")
				assert.Equal("10.100.0.2/32", sp.Get("match.destIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("AR", sp.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
				assert.Equal("all", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			}

			rule103 := gcloud.Run(t, fmt.Sprintf("compute network-firewall-policies rules describe 103 --firewall-policy %s --firewall-policy-region %s --project %s", policyName, policyRegion, projectID))
			for _, sp := range rule103.Array() {
				assert.Equal("allow", sp.Get("action").String(), "Rule103 action should be allow")
				assert.Equal("egress-103", sp.Get("ruleName").String(), "Rule103 ruleName should be ingress-103")
				assert.Equal("test ingres rule 103", sp.Get("description").String(), "Rule103 has expected description")
				assert.Equal("EGRESS", sp.Get("direction").String(), "Rule103 direction should be INGRESS")
				assert.True(sp.Get("disabled").Bool(), "Rule103 should be disabled")
				assert.True(sp.Get("enableLogging").Bool(), "Rule103 Logging should be enabled")
				assert.Equal("10.100.0.103/32", sp.Get("match.destIpRanges").Array()[0].String(), "has expected srcIpRanges")
				assert.Equal("tcp", sp.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
				layer4ConfigsPorts := sp.Get("match.layer4Configs").Array()[0].Get("ports").Array()
				assert.Equal(3, len(layer4ConfigsPorts), "should have the correct destination address group count")
			}

		})
	fwp.Test()
}
