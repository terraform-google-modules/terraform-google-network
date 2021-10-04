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

package serverless

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSubmoduleServerlessConnector(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			// disable diff test due to https://github.com/hashicorp/terraform-provider-google/issues/10244
			// net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			gcOps := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-central1", "--format", "json"})

			connector := gcloud.Run(t, "beta compute networks vpc-access connectors describe central-serverless", gcOps)
			assert.Equal("e2-standard-4", connector.Get("machineType").String(), "should have correct machinetype")
			assert.Equal("serverless-subnet", connector.Get("subnet.name").String(), "should have correct subnet")
		})
	net.Test()
}
