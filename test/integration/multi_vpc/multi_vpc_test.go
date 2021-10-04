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

func TestMultiVPC(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			networks := []string{net.GetStringOutput("network_01_name"), net.GetStringOutput("network_02_name")}

			for _, netName := range networks {
				route := gcloud.Run(t, fmt.Sprintf("compute routes describe %s-egress-inet --project %s", netName, projectID))
				assert.Equal("0.0.0.0/0", route.Get("destRange").String(), "should equal 0.0.0.0/0")
				assert.Equal(1, len(route.Get("tags").Array()), "should have one tag")
				assert.Equal("egress-inet", route.Get("tags").Array()[0].String(), "tag should equal egress-inet")
				expectedNextHopGateway := fmt.Sprintf("https://www.googleapis.com/compute/v1/projects/%s/global/gateways/default-internet-gateway", projectID)
				assert.Equal(expectedNextHopGateway, route.Get("nextHopGateway").String(), fmt.Sprintf("should equal %s", expectedNextHopGateway))
			}

			routeAppProxy := gcloud.Run(t, fmt.Sprintf("compute routes describe %s-testapp-proxy --project %s", net.GetStringOutput("network_02_name"), projectID))
			assert.Equal("10.50.10.0/24", routeAppProxy.Get("destRange").String(), "should equal 10.50.10.0/24")
			assert.Equal(1, len(routeAppProxy.Get("tags").Array()), "should have one tag")
			assert.Equal("app-proxy", routeAppProxy.Get("tags").Array()[0].String(), "should equal app-proxy")
			assert.Equal(1, len(routeAppProxy.Get("nextHopIp").Array()), "should have one nextHopIp")
			assert.Equal("10.10.40.10", routeAppProxy.Get("nextHopIp").Array()[0].String(), "nextHopIp should equal 10.10.40.10")
		})
	net.Test()
}
