// Copyright 2024 Google LLC
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

package ncc

import (
	// "strings"

	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestNetworkConnectivityCenter(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			// net.DefaultVerify(assert) Disable due to bug in provider. Reenable it after the bug is fixed
			projectID := net.GetStringOutput("project_id")
			nccHubName := net.GetStringOutput("ncc_hub_name")
			expectedNccSpokesCount := 3

			op := gcloud.Run(t, "network-connectivity hubs describe ", gcloud.WithCommonArgs([]string{nccHubName, "--project", projectID, "--format", "json"}))
			nccSpokeStateCount := op.Get("spokeSummary.spokeStateCounts").Array()
			assert.Equal(1, len(nccSpokeStateCount), "should have spokes in one State")
			assert.Equal("ACTIVE", nccSpokeStateCount[0].Get("state").String(), "should have only active spokes")
			assert.Equal(int64(expectedNccSpokesCount), nccSpokeStateCount[0].Get("count").Int(), "should have exactly 3 spokes")
			assert.Equal(expectedNccSpokesCount, len(op.Get("spokeSummary.spokeTypeCounts").Array()), "should have 3 different spoke types")
		})
	net.Test()
}
