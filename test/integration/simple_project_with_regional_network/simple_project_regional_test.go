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

package regional

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimpleProjectWithRegionalNetwork(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)

			vpc := gcloud.Run(t, fmt.Sprintf("compute networks describe %s --project %s", net.GetStringOutput("network_name"), net.GetStringOutput("project_id")))
			assert.Equal("REGIONAL", vpc.Get("routingConfig.routingMode").String(), "should have REGIONAL routing_mode")

		})
	net.Test()
}
