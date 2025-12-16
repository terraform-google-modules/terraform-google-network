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

func TestPrivateServiceConnectEndpointsForPublishedServices(t *testing.T) {
	psc := tft.NewTFBlueprintTest(t)
	psc.DefineVerify(
		func(assert *assert.Assertions) {
			psc.DefaultVerify(assert)
			projectID := psc.GetStringOutput("project_id")
			gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-east1", "--format", "json"})

			regionAddressName := psc.GetStringOutput("address_name")
			regionAddressIp := psc.GetStringOutput("ip_address")
			regionAddress := gcloud.Run(t, fmt.Sprintf("compute addresses describe %s", regionAddressName), gcOpts)
			assert.Equalf(regionAddressIp, regionAddress.Get("address").String(), "private service connect ip should be %s", regionAddressIp)

			forwardingRuleName := psc.GetStringOutput("forwarding_rule_name")
			forwardingRuleTarget := psc.GetStringOutput("forwarding_rule_target")
			forwardingRule := gcloud.Run(t, fmt.Sprintf("compute forwarding-rules describe %s", forwardingRuleName), gcOpts)
			assert.Equalf(forwardingRuleTarget, forwardingRule.Get("target").String(), "forwarding rule should target to %s", forwardingRuleTarget)
		})
	psc.Test()
}
