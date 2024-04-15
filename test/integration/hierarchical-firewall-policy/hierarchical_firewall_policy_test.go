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

package hierarchical_firewall_policy

import (
	"testing"
	// "fmt"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestHierarchicalFirewallPolicy(t *testing.T) {
	fwp := tft.NewTFBlueprintTest(t)
	fwp.DefineVerify(
		func(assert *assert.Assertions) {

			// Commenting Default Verify because the provider updates rule_tuple_count, results in a permadiff.
			fwp.DefaultVerify(assert)
			projectId := fwp.GetStringOutput("project_id")
			policyName := fwp.GetStringOutput("fw_policy_name")
			policyId := fwp.GetStringOutput("fw_policy_id")
			policyParentFolder := fwp.GetStringOutput("fw_policy_parent_folder")
			PolicyNoRulesName := fwp.GetStringOutput("firewal_policy_no_rules_name")
			PolicyNoRulesId := fwp.GetStringOutput("firewal_policy_no_rules_id")
			PolicyNoRulesParentFolder := fwp.GetStringOutput("firewal_policy_no_rules_parent_folder")

			policyNoRules := gcloud.Runf(t, "compute firewall-policies describe %s --project %s", PolicyNoRulesId, projectId)
			spnr := policyNoRules.Array()[0]
			assert.Equal(PolicyNoRulesName, spnr.Get("displayName").String(), "has expected name")
			assert.Equal("hierarchical test firewall policy without any rules", spnr.Get("description").String(), "has expected description")
			assert.Equal(PolicyNoRulesParentFolder, spnr.Get("parent").String(), "has expected parent folder")

			policy := gcloud.Runf(t, "compute firewall-policies describe %s --project %s", policyId, projectId)
			sp := policy.Array()[0]
			assert.Equal(policyName, sp.Get("displayName").String(), "has expected policy name")
			assert.Equal(policyParentFolder, sp.Get("parent").String(), "has expected parent folder")
			assert.Equal("test hierarchical firewall policy", sp.Get("description").String(), "has expected description")

			rule1 := gcloud.Runf(t, "compute firewall-policies rules describe 1 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("allow", rule1.Get("action").String(), "Rule1 action should be allow")
			assert.Equal("test ingres rule 1", rule1.Get("description").String(), "Rule1 has expected description")
			assert.Equal("1", rule1.Get("priority").String(), "Rule1 has priority 1")
			assert.Equal("INGRESS", rule1.Get("direction").String(), "Rule1 direction should be INGRESS")
			assert.False(rule1.Get("disabled").Bool(), "Rule1 should be enabled")
			assert.True(rule1.Get("enableLogging").Bool(), "Rule1 Logging should be enabled")
			assert.Equal("example.com", rule1.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
			assert.Equal("10.100.0.1/32", rule1.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("US", rule1.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
			assert.Equal("all", rule1.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")

			rule2 := gcloud.Runf(t, "compute firewall-policies rules describe 2 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("deny", rule2.Get("action").String(), "Rule2 action should be deny")
			assert.Equal("test ingres rule 2", rule2.Get("description").String(), "Rule2 has expected description")
			assert.Equal("INGRESS", rule2.Get("direction").String(), "Rule2 direction should be INGRESS")
			assert.True(rule2.Get("disabled").Bool(), "Rule2 should be Disabled")
			assert.False(rule2.Get("enableLogging").Bool(), "Rule2 Logging should be disabled")
			assert.Equal("example.org", rule2.Get("match.srcFqdns").Array()[0].String(), "has expected srcFqdns")
			assert.Equal("10.100.0.2/32", rule2.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("BE", rule2.Get("match.srcRegionCodes").Array()[0].String(), "has expected srcRegionCodes")
			assert.Equal("all", rule2.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")

			rule3 := gcloud.Runf(t, "compute firewall-policies rules describe 3 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("allow", rule3.Get("action").String(), "Rule3 action should be allow")
			assert.Equal("test ingres rule 3", rule3.Get("description").String(), "Rule3 has expected description")
			assert.Equal("INGRESS", rule3.Get("direction").String(), "Rule3 direction should be INGRESS")
			assert.True(rule3.Get("disabled").Bool(), "Rule3 should be disabled")
			assert.True(rule3.Get("enableLogging").Bool(), "Rule3 Logging should be enabled")
			assert.Equal("10.100.0.3/32", rule3.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("10.100.0.103/32", rule3.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", rule3.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			layer4ConfigsPorts3 := rule3.Get("match.layer4Configs").Array()[0].Get("ports").Array()
			assert.Equal(1, len(layer4ConfigsPorts3), "should have the correct layer4Configs port count")
			targetServiceAccounts3 := rule3.Get("targetServiceAccounts").Array()
			assert.Equal(1, len(targetServiceAccounts3), "Rule3 should have the correct targetServiceAccounts count")

			rule101 := gcloud.Runf(t, "compute firewall-policies rules describe 101 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("allow", rule101.Get("action").String(), "Rule101 action should be allow")
			assert.Equal("test egress rule 101", rule101.Get("description").String(), "Rule101has expected description")
			assert.Equal("EGRESS", rule101.Get("direction").String(), "Rule101 direction should be EGRESS")
			assert.False(rule101.Get("disabled").Bool(), "Rule101 should be enabled")
			assert.True(rule101.Get("enableLogging").Bool(), "Rule101 Logging should be enabled")
			assert.Equal("example.com", rule101.Get("match.destFqdns").Array()[0].String(), "has expected destFqdns")
			assert.Equal("10.100.0.2/32", rule101.Get("match.srcIpRanges").Array()[0].String(), "has expected srcIpRanges")
			assert.Equal("US", rule101.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
			assert.Equal("all", rule101.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			assert.Equal("iplist-public-clouds", rule101.Get("match.destThreatIntelligences").Array()[0].String(), "has expected srcIpRanges")

			rule102 := gcloud.Runf(t, "compute firewall-policies rules describe 102 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("deny", rule102.Get("action").String(), "Rule102 action should be deny")
			assert.Equal("test egress rule 102", rule102.Get("description").String(), "Rule102 has expected description")
			assert.Equal("EGRESS", rule102.Get("direction").String(), "Rule102 direction should be EGRESS")
			assert.True(rule102.Get("disabled").Bool(), "Rule102 should be disabled")
			assert.False(rule102.Get("enableLogging").Bool(), "Rule102 Logging should be disabled")
			assert.Equal("10.100.0.2/32", rule102.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("AR", rule102.Get("match.destRegionCodes").Array()[0].String(), "has expected destRegionCodes")
			assert.Equal("all", rule102.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")

			rule103 := gcloud.Runf(t, "compute firewall-policies rules describe 103 --firewall-policy  %s --project %s", policyId, projectId)
			assert.Equal("allow", rule103.Get("action").String(), "Rule103 action should be allow")
			assert.Equal("test ingres rule 103", rule103.Get("description").String(), "Rule103 has expected description")
			assert.Equal("EGRESS", rule103.Get("direction").String(), "Rule103 direction should be EGRESS")
			assert.True(rule103.Get("disabled").Bool(), "Rule103 should be disabled")
			assert.True(rule103.Get("enableLogging").Bool(), "Rule103 Logging should be enabled")
			assert.Equal("10.100.0.103/32", rule103.Get("match.destIpRanges").Array()[0].String(), "has expected destIpRanges")
			assert.Equal("tcp", rule103.Get("match.layer4Configs").Array()[0].Get("ipProtocol").String(), "has expected layer4Configs.ipProtocol")
			layer4ConfigsPorts103 := rule103.Get("match.layer4Configs").Array()[0].Get("ports").Array()
			assert.Equal(3, len(layer4ConfigsPorts103), "Rule3 should have the correct layer4Configs.ports count")
			targetServiceAccounts103 := rule103.Get("targetServiceAccounts").Array()
			assert.Equal(1, len(targetServiceAccounts103), "Rule3should have the correct targetServiceAccounts count")

		})
	fwp.Test()
}
