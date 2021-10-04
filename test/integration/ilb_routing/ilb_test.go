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

package ilb

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestILBRouting(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			netName := net.GetStringOutput("network_name")
			gcOps := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-west1", "--format", "json"})

			subnet1 := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s-subnet", netName), gcOps)
			assert.Equal("PRIVATE", subnet1.Get("purpose").String(), "purpose should be PRIVATE")
			assert.False(subnet1.Get("role").Exists(), "role should not exist")

			subnet2 := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s-subnet-01", netName), gcOps)
			assert.Equal("INTERNAL_HTTPS_LOAD_BALANCER", subnet2.Get("purpose").String(), "purpose should be INTERNAL_HTTPS_LOAD_BALANCER")
			assert.Equal("ACTIVE", subnet2.Get("role").String(), "role should be ACTIVE")

			subnet3 := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s-subnet-02", netName), gcOps)
			assert.Equal("INTERNAL_HTTPS_LOAD_BALANCER", subnet3.Get("purpose").String(), "purpose should be INTERNAL_HTTPS_LOAD_BALANCER")
			assert.Equal("BACKUP", subnet3.Get("role").String(), "role should be BACKUP")

			route := gcloud.Run(t, fmt.Sprintf("compute routes describe %s-ilb", netName), gcloud.WithCommonArgs([]string{"--project", projectID, "--format", "json"}))
			assert.Equal("10.10.20.0/24", route.Get("destRange").String(), "should equal 10.10.20.0/24")
			assert.False(route.Get("tags").Exists(), "tags should not exist")
			assert.Equal(net.GetStringOutput("forwarding_rule"), route.Get("nextHopIlb").String(), "should equal the forwarding rule")
		})
	net.Test()
}
