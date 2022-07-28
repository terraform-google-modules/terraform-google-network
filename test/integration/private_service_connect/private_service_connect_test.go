// Copyright 2022 Google LLC
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

package psc

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestPrivateServiceConnect(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"})

			vpc := gcloud.Run(t, fmt.Sprintf("compute networks describe %s", net.GetStringOutput("network_name")), gcOpts)
			assert.Equal(1, len(vpc.Get("subnetworks").Array()), "should be one subnet")

			for _, dnsOutputName := range []string{
				"dns_zone_googleapis_name",
				"dns_zone_gcr_name",
				"dns_zone_pkg_dev_name",
			} {
				dnsName := net.GetStringOutput(dnsOutputName)
				dnsZone := gcloud.Run(t, fmt.Sprintf("dns managed-zones describe %s", dnsName), gcOpts)
				assert.Equalf(dnsName, dnsZone.Get("name").String(), "dnsZone %s should exist", dnsName)
			}

			gcOpts = gcloud.WithCommonArgs([]string{"--project", projectID, "--global", "--format", "json"})

			globalAddressName := net.GetStringOutput("private_service_connect_name")
			globalAddressIp := net.GetStringOutput("private_service_connect_ip")
			globalAddress := gcloud.Run(t, fmt.Sprintf("compute addresses describe %s", globalAddressName), gcOpts)
			assert.Equalf(globalAddressIp, globalAddress.Get("address").String(), "private service connect ip should be %s", globalAddressIp)

			forwardingRuleName := net.GetStringOutput("forwarding_rule_name")
			forwardingRuleTarget := net.GetStringOutput("forwarding_rule_target")
			forwardingRule := gcloud.Run(t, fmt.Sprintf("compute forwarding-rules describe %s", forwardingRuleName), gcOpts)
			assert.Equalf(forwardingRuleTarget, forwardingRule.Get("target").String(), "forwarding rule should target to %s", forwardingRuleTarget)
		})
	net.Test()
}
