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

package submodulefw

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
	"github.com/tidwall/gjson"
)

func TestSubmoduleFirewall(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			networkName := net.GetStringOutput("network_name")
			WithNetPrefix := func(s string) string { return fmt.Sprintf("%s%s", networkName, s) }

			// check all expected FWs
			expectedFWs := []string{WithNetPrefix("-ingress-internal"), WithNetPrefix("-ingress-tag-http"), WithNetPrefix("-ingress-tag-https"), WithNetPrefix("-ingress-tag-ssh"), "deny-ingress-6534-6566", "allow-backend-to-databases", "allow-all-admin-sa"}
			for _, fw := range expectedFWs {
				gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe %s --project %s", fw, projectID)).Array()
			}

			fwIngress := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe %s-ingress-internal --project %s", networkName, projectID))
			assert.ElementsMatch([]string{"10.10.20.0/24", "10.10.10.0/24"}, getResultStrSlice(fwIngress.Get("sourceRanges").Array()), "should have correct sourceRanges")
			fwExpectedProtocols := []string{"icmp", "udp", "tcp"}
			fwAllowedProtocolPorts := fwIngress.Get("allowed").Array()
			assert.Equal(len(fwExpectedProtocols), len(fwAllowedProtocolPorts), "should have the correct number of allowed protocols")
			for _, protoPort := range fwAllowedProtocolPorts {
				if protoPort.Get("IPProtocol").String() == "tcp" {
					assert.ElementsMatch([]string{"8080", "1000-2000"}, getResultStrSlice(protoPort.Get("ports").Array()), "should have the correct ports for TCP")
				}
			}

			fwDB := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe allow-backend-to-databases --project %s", projectID))
			assert.ElementsMatch([]string{"backed"}, getResultStrSlice(fwDB.Get("sourceTags").Array()), "should have backend tag as sources")
			assert.ElementsMatch([]string{"databases"}, getResultStrSlice(fwDB.Get("targetTags").Array()), "should have databases tag as target")
			fwAllowedProtocolPorts = fwDB.Get("allowed").Array()
			for _, protoPort := range fwAllowedProtocolPorts {
				if protoPort.Get("IPProtocol").String() == "tcp" {
					assert.ElementsMatch([]string{"3306", "5432", "1521", "1433"}, getResultStrSlice(protoPort.Get("ports").Array()), "should have the correct ports for TCP")
				}
			}
			assert.False(fwDB.Get("logConfig.enable").Bool(), "should have logging disabled")

			fwDeny := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe deny-ingress-6534-6566 --project %s", projectID))
			assert.True(fwDeny.Get("disabled").Bool(), "should be disabled")
			assert.ElementsMatch([]string{"0.0.0.0/0"}, getResultStrSlice(fwDeny.Get("sourceRanges").Array()), "has 0.0.0.0/0 source range")
			fwDeniedProtocolPorts := fwDeny.Get("denied").Array()
			for _, protoPort := range fwDeniedProtocolPorts {
				protocol := protoPort.Get("IPProtocol").String()
				if protocol == "tcp" || protocol == "udp" {
					assert.ElementsMatch([]string{"6534-6566"}, getResultStrSlice(protoPort.Get("ports").Array()), fmt.Sprintf("should have the correct ports for %s", protocol))
				}
			}
			assert.True(fwDeny.Get("logConfig.enable").Bool(), "should have logging enabled")
			assert.Equal("EXCLUDE_ALL_METADATA", fwDeny.Get("logConfig.metadata").String(), "has expected logging metadata")

			fwAdmin := gcloud.Run(t, fmt.Sprintf("compute firewall-rules describe allow-all-admin-sa --project %s", projectID))
			assert.False(fwAdmin.Get("disabled").Bool(), "should be enabled")
			assert.ElementsMatch([]string{"admin@my-shiny-org.iam.gserviceaccount.com"}, getResultStrSlice(fwAdmin.Get("sourceServiceAccounts").Array()), "should has correct source SA")
			assert.Equal("30", fwAdmin.Get("priority").String(), "should have priority 30")

			fwExpectedProtocols = []string{"udp", "tcp"}
			fwAllowedProtocolPorts = fwAdmin.Get("allowed").Array()
			assert.Equal(len(fwExpectedProtocols), len(fwAllowedProtocolPorts), "should have the correct number of allowed protocols")
			for _, protoPort := range fwAllowedProtocolPorts {
				assert.Contains(fwExpectedProtocols, protoPort.Get("IPProtocol").String(), "has expected protocols")
			}
			assert.True(fwAdmin.Get("logConfig.enable").Bool(), "should have logging enabled")
			assert.Equal("INCLUDE_ALL_METADATA", fwAdmin.Get("logConfig.metadata").String(), "has expected logging metadata")
		})
	net.Test()
}

// getResultStrSlice parses results into a string slice
func getResultStrSlice(rs []gjson.Result) []string {
	s := make([]string, 0)
	for _, r := range rs {
		s = append(s, r.String())
	}
	return s
}
