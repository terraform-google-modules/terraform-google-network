/**
 * Copyright 2026 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package private_service_access

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestPrivateServiceAccess(t *testing.T) {
	psaTest := tft.NewTFBlueprintTest(t)

	psaTest.DefineVerify(func(assert *assert.Assertions) {
		psaTest.DefaultVerify(assert)

		projectID := psaTest.GetStringOutput("project_id")
		networkName := psaTest.GetStringOutput("network_name")
		addressName := "private-ip-address" // Matches the default in our module

		// 1. Verify the Global Address reserved for Private Service Access
		addressOp := gcloud.Run(t, fmt.Sprintf("compute addresses describe %s --global --project %s --format=json", addressName, projectID))
		assert.Equal("INTERNAL", addressOp.Get("addressType").String(), "Address type should be INTERNAL")
		assert.Equal("VPC_PEERING", addressOp.Get("purpose").String(), "Address purpose should be VPC_PEERING")
		assert.Equal(int64(16), addressOp.Get("prefixLength").Int(), "Address prefix length should be 16")

		// 2. Verify the VPC Peering connection to Service Networking
		// We list peerings for the network and check for the service networking peering
		peeringOp := gcloud.Run(t, fmt.Sprintf("services vpc-peerings list --network %s --project %s --format=json", networkName, projectID))
		
		// Find the peering for 'servicenetworking.googleapis.com'
		foundPeering := false
		for _, peering := range peeringOp.Array() {
			if peering.Get("service").String() == "servicenetworking.googleapis.com" {
				foundPeering = true
				assert.Contains(peering.Get("reservedPeeringRanges").Export().([]interface{}), addressName, "Peering should use the reserved IP range")
				break
			}
		}
		assert.True(foundPeering, "VPC Peering for servicenetworking.googleapis.com should exist")
	})

	psaTest.Test()
}
