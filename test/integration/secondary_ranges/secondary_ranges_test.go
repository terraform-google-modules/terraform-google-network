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

package multi

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSecondaryRanges(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			networkName := net.GetStringOutput("network_name")
			gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-west1", "--format", "json"})

			subnetWithRanges := map[string][]string{"-subnet-01": {"192.168.64.0/24", "192.168.65.0/24"}, "-subnet-03": {"192.168.66.0/24"}}
			for suffix, expectedRanges := range subnetWithRanges {
				subnetName := fmt.Sprintf("%s%s", networkName, suffix)
				subnet := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s", subnetName), gcOpts)
				gotRanges := subnet.Get("secondaryIpRanges").Array()
				assert.Equal(len(expectedRanges), len(gotRanges), "has expected number of secondary ranges")
				for i, cidr := range expectedRanges {
					assert.Equal(cidr, gotRanges[i].Get("ipCidrRange").String(), "has expected secondary range")
					assert.Equal(fmt.Sprintf("%s-0%d", subnetName, i+1), gotRanges[i].Get("rangeName").String(), "has expected secondary range name")
				}
			}

			subnetsWithoutRanges := []string{"-subnet-02", "-subnet-04"}
			for _, suffix := range subnetsWithoutRanges {
				subnet := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s%s", networkName, suffix), gcOpts)
				assert.False(subnet.Get("secondaryIpRanges").Exists(), "does not have secondary ranges")
			}

			fwIngress := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe allow-ssh-ingress --project %s", projectID))
			assert.Equal("tcp", fwIngress.Get("allowed").Array()[0].Get("IPProtocol").String(), "should have the correct allow rule protocol")
			fwPort := fwIngress.Get("allowed").Array()[0].Get("ports").Array()
			assert.Equal(1, len(fwPort), "should have the correct allow rule ports count")
			assert.Equal("22", fwPort[0].String(), "should have the correct allow rule port")

			fwEgress := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe deny-udp-egress --project %s", projectID))
			assert.Equal("udp", fwEgress.Get("denied").Array()[0].Get("IPProtocol").String(), "should have the correct deny rule protocol")
		})
	net.Test()
}
