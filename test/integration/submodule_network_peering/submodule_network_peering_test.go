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

package peering

import (
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/tidwall/gjson"
)

func TestSubmodulePeering(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			// skip default verify as output diff may happen as peering state changes aync
			// net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")

			expectedPeerings := []string{"peering1", "peering2"}
			for _, ep := range expectedPeerings {
				peering := parseJSONResult(t, terraform.OutputJson(t, net.GetTFOptions(), ep))
				localPeeringName, localNetworkSelfLink, localNetworkName := getPeeringInfo(peering.Get("local_network_peering"))
				peerPeeringName, peerNetworkSelfLink, peerNetworkName := getPeeringInfo(peering.Get("peer_network_peering"))

				gcOps := gcloud.WithCommonArgs([]string{"--project", projectID, "--network", localNetworkName, "--format", "json"})
				peerings := gcloud.Run(t, "compute networks peerings list", gcOps).Array()[0].Get("peerings").Array()
				matchedPeering := getFirstMatchResult(t, peerings, "name", localPeeringName)

				assert.Equal("ACTIVE", matchedPeering.Get("state").String(), "should be ACTIVE")
				assert.Equal(peerNetworkSelfLink, matchedPeering.Get("network").String(), "should be peered to peer network")
				assert.True(matchedPeering.Get("exportCustomRoutes").Bool(), "exportCustomRoutes should be true")
				assert.False(matchedPeering.Get("importCustomRoutes").Bool(), "importCustomRoutes should be false")

				gcOps = gcloud.WithCommonArgs([]string{"--project", projectID, "--network", peerNetworkName, "--format", "json"})
				peerings = gcloud.Run(t, "compute networks peerings list", gcOps).Array()[0].Get("peerings").Array()
				matchedPeering = getFirstMatchResult(t, peerings, "name", peerPeeringName)

				assert.Equal("ACTIVE", matchedPeering.Get("state").String(), "should be ACTIVE")
				assert.Equal(localNetworkSelfLink, matchedPeering.Get("network").String(), "should be peered to local network")
				assert.False(matchedPeering.Get("exportCustomRoutes").Bool(), "exportCustomRoutes should be false")
				assert.True(matchedPeering.Get("importCustomRoutes").Bool(), "importCustomRoutes should be true")
			}
		})
	net.Test()
}

// getPeeringInfo return name, networkSelfLink and networkName from a peering result
func getPeeringInfo(peering gjson.Result) (string, string, string) {
	peeringName := peering.Get("name").String()
	networkSelfLink := peering.Get("network").String()
	networkSelfLinkSlice := strings.Split(networkSelfLink, "/")
	networkName := networkSelfLinkSlice[len(networkSelfLinkSlice)-1]
	return peeringName, networkSelfLink, networkName
}

// parseJSONResult converts a JSON string into gjson result
func parseJSONResult(t *testing.T, j string) gjson.Result {
	if !gjson.Valid(j) {
		t.Fatalf("Error parsing output, invalid json: %s", j)
	}
	return gjson.Parse(j)
}

// getFirstMatchResult returns the first matching result with a given k/v
func getFirstMatchResult(t *testing.T, rs []gjson.Result, k, v string) gjson.Result {
	for _, r := range rs {
		if r.Get(k).Exists() && r.Get(k).String() == v {
			return r
		}
	}
	t.Fatalf("unable to find key %s with value %s in %s", k, v, rs)
	return gjson.Result{}
}
