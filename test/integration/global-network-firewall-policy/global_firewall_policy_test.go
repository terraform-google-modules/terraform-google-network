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

package global_network_firewall_policy

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestGlobalNetworkFirewallPolicy(t *testing.T) {
	fwp := tft.NewTFBlueprintTest(t)
	fwp.DefineVerify(
		func(assert *assert.Assertions) {

			// Commenting Default Verify because the provider updates rule_tuple_count, results in a permadiff.
			// fwp.DefaultVerify(assert)
			projectId := fwp.GetStringOutput("project_id")
			policyName := fwp.GetStringOutput("firewall_policy_name")
			firewalPolicyNoRulesName := fwp.GetStringOutput("firewal_policy_no_rules_name")

			policyNoRules := gcloud.Runf(t, "compute network-firewall-policies describe %s --global --project %s", firewalPolicyNoRulesName, projectId)
			spnr := policyNoRules.Array()[0]
			assert.Equal(firewalPolicyNoRulesName, spnr.Get("name").String(), "has expected name")
			assert.Equal("global test firewall policy without any rules", spnr.Get("description").String(), "has expected name")

			policy := gcloud.Runf(t, "compute network-firewall-policies describe %s --global --project %s", policyName, projectId)
			sp := policy.Array()[0]
			assert.Equal(policyName, sp.Get("name").String(), "has expected name")
			assert.Equal("test global firewall policy", sp.Get("description").String(), "has expected name")

			rule1 := gcloud.Runf(t, "compute network-firewall-policies rules describe 1 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp1 := rule1.Array()[0]
			assert.Equal("allow", sp1.Get("action").String(), "Rule1 action should be allow")
			assert.Equal("ingress-1", sp1.Get("ruleName").String(), "Rule1 ruleName should be ingress-1")
			assert.Equal("test ingres rule 1", sp1.Get("description").String(), "Rule1 has expected description")
			assert.Equal("INGRESS", sp1.Get("direction").String(), "Rule1 direction should be INGRESS")
			assert.False(sp1.Get("disabled").Bool(), "Rule1 should be enabled")
			assert.True(sp1.Get("enableLogging").Bool(), "Rule1 Logging should be enabled")
			assert.Equal("google.com", sp1.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
			assert.Equal("10.100.0.1/32", sp1.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("US", sp1.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
			assert.Equal("all", sp1.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			secureTags1 := sp1.Get("match.srcSecureTags").Array()
			assert.Equal(1, len(secureTags1), "should have the correct srcSecureTags count - 1")
			srcAddressGroups := sp1.Get("match.srcAddressGroups").Array()
			assert.Equal(1, len(srcAddressGroups), "should have the correct srcAddressGroups count")

			rule2 := gcloud.Runf(t, "compute network-firewall-policies rules describe 2 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp2 := rule2.Array()[0]
			assert.Equal("deny", sp2.Get("action").String(), "Rule2 action should be deny")
			assert.Equal("ingress-2", sp2.Get("ruleName").String(), "Rule2 ruleName should be ingress-2")
			assert.Equal("test ingres rule 2", sp2.Get("description").String(), "Rule2 has expected description")
			assert.Equal("INGRESS", sp2.Get("direction").String(), "Rule2 direction should be INGRESS")
			assert.True(sp2.Get("disabled").Bool(), "Rule2 should be Disabled")
			assert.False(sp2.Get("enableLogging").Bool(), "Rule2 Logging should be disabled")
			assert.Equal("google.org", sp2.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
			assert.Equal("10.100.0.2/32", sp2.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("BE", sp2.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
			assert.Equal("all", sp2.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			secureTags2 := sp2.Get("targetSecureTags").Array()
			assert.Equal(1, len(secureTags2), "should have the correct targetSecureTags count - 1")

			rule3 := gcloud.Runf(t, "compute network-firewall-policies rules describe 3 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp3 := rule3.Array()[0]
			assert.Equal("allow", sp3.Get("action").String(), "Rule3 action should be allow")
			assert.Equal("ingress-3", sp3.Get("ruleName").String(), "Rule3 ruleName should be ingress-3")
			assert.Equal("test ingres rule 3", sp3.Get("description").String(), "Rule3 has expected description")
			assert.Equal("INGRESS", sp3.Get("direction").String(), "Rule3 direction should be INGRESS")
			assert.True(sp3.Get("disabled").Bool(), "Rule3 should be disabled")
			assert.True(sp3.Get("enableLogging").Bool(), "Rule3 Logging should be enabled")
			assert.Equal("10.100.0.3/32", sp3.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("10.100.0.103/32", sp3.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", sp3.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			layer4ConfigsPorts3 := sp3.Get("match.layer4Configs").Array()[0].Get("ports").Array()
			assert.Equal(1, len(layer4ConfigsPorts3), "should have the correct layer4Configs port count")
			targetServiceAccounts3 := sp3.Get("targetServiceAccounts").Array()
			assert.Equal(1, len(targetServiceAccounts3), "Rule3 should have the correct targetServiceAccounts count")

			rule101 := gcloud.Runf(t, "compute network-firewall-policies rules describe 101 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp101 := rule101.Array()[0]
			assert.Equal("allow", sp101.Get("action").String(), "Rule101 action should be allow")
			assert.Equal("egress-101", sp101.Get("ruleName").String(), "Rule101 ruleName should be egress-101")
			assert.Equal("test egress rule 101", sp101.Get("description").String(), "Rule101has expected description")
			assert.Equal("EGRESS", sp101.Get("direction").String(), "Rule101 direction should be EGRESS")
			assert.False(sp101.Get("disabled").Bool(), "Rule101 should be enabled")
			assert.True(sp101.Get("enableLogging").Bool(), "Rule101 Logging should be enabled")
			assert.Equal("google.com", sp101.Get("match.destFqdns").Array()[0].String(), "has expected destFqdns")
			assert.Equal("10.100.0.2/32", sp101.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("US", sp101.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
			assert.Equal("all", sp101.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			assert.Equal("iplist-public-clouds", sp101.Get("match.destThreatIntelligences").Array()[0].String(), "has expected srcIpRanges")
			destAddressGroups := sp101.Get("match.destAddressGroups").Array()
			assert.Equal(1, len(destAddressGroups), "rule101 should have the correct destAddressGroups count")

			rule102 := gcloud.Runf(t, "compute network-firewall-policies rules describe 102 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp102 := rule102.Array()[0]
			assert.Equal("deny", sp102.Get("action").String(), "Rule102 action should be deny")
			assert.Equal("egress-102", sp102.Get("ruleName").String(), "Rule102 ruleName should be egress-102")
			assert.Equal("test egress rule 102", sp102.Get("description").String(), "Rule102 has expected description")
			assert.Equal("EGRESS", sp102.Get("direction").String(), "Rule102 direction should be EGRESS")
			assert.True(sp102.Get("disabled").Bool(), "Rule102 should be disabled")
			assert.False(sp102.Get("enableLogging").Bool(), "Rule102 Logging should be disabled")
			assert.Equal("10.100.0.2/32", sp102.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("AR", sp102.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
			assert.Equal("all", sp102.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			secureTags102 := sp102.Get("targetSecureTags").Array()
			assert.Equal(1, len(secureTags102), "should have the correct targetSecureTags count - 1")

			rule103 := gcloud.Runf(t, "compute network-firewall-policies rules describe 103 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp103 := rule103.Array()[0]
			assert.Equal("allow", sp103.Get("action").String(), "Rule103 action should be allow")
			assert.Equal("egress-103", sp103.Get("ruleName").String(), "Rule103 ruleName should be egress-103")
			assert.Equal("test ingres rule 103", sp103.Get("description").String(), "Rule103 has expected description")
			assert.Equal("EGRESS", sp103.Get("direction").String(), "Rule103 direction should be EGRESS")
			assert.True(sp103.Get("disabled").Bool(), "Rule103 should be disabled")
			assert.True(sp103.Get("enableLogging").Bool(), "Rule103 Logging should be enabled")
			assert.Equal("10.100.0.103/32", sp103.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", sp103.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			layer4ConfigsPorts103 := sp103.Get("match.layer4Configs").Array()[0].Get("ports").Array()
			assert.Equal(3, len(layer4ConfigsPorts103), "Rule3 should have the correct layer4Configs.ports count")
			targetServiceAccounts103 := sp103.Get("targetServiceAccounts").Array()
			assert.Equal(1, len(targetServiceAccounts103), "Rule3should have the correct targetServiceAccounts count")

			rule200 := gcloud.Runf(t, "beta compute network-firewall-policies mirroring-rules describe 200 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp104 := rule200.Array()[0]
			assert.Equal("mirror", sp104.Get("action").String(), "Rule200 action should be mirror")
			assert.Equal("egress-200", sp104.Get("ruleName").String(), "Rule200 ruleName should be egress-200")
			assert.Equal("test egress mirroring rule 200", sp104.Get("description").String(), "Rule200 has expected description")
			assert.Equal("EGRESS", sp104.Get("direction").String(), "Rule200 direction should be EGRESS")
			assert.Equal( "0.0.0.0/0", sp104.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", sp104.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			layer4ConfigsPorts200 := sp104.Get("match.layer4Configs").Array()[0].Get("ports").Array()
			assert.Equal(1, len(layer4ConfigsPorts200), "Rule3 should have the correct layer4Configs.ports count")

			rule300 := gcloud.Runf(t, "compute network-firewall-policies rules describe 300 --global-firewall-policy --firewall-policy %s --project %s", policyName, projectId)
			sp300 := rule300.Array()[0]
			assert.Equal("apply_security_profile_group", sp300.Get("action").String(), "Rule300 action should be allow")
			assert.Equal("egress-300", sp300.Get("ruleName").String(), "Rule300 ruleName should be egress-300")
			assert.Equal("test egress threat prevention rule 300", sp300.Get("description").String(), "Rule300 has expected description")
			assert.Equal("EGRESS", sp300.Get("direction").String(), "Rule300 direction should be EGRESS")
			assert.Equal("0.0.0.0/0", sp300.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", sp300.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
	})
	fwp.Test()
}
