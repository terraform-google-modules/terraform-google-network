package simple

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimpleProject(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-west1", "--format", "json"})

			vpc := gcloud.Run(t, fmt.Sprintf("compute networks describe %s --project %s", net.GetStringOutput("network_name"), projectID))
			assert.Equal(3, len(vpc.Get("subnetworks").Array()), "should have three subnets")

			subnet1 := gcloud.Run(t, "compute networks subnets describe subnet-01", gcOpts)
			assert.Equal("10.10.10.0/24", subnet1.Get("ipCidrRange").String(), "should have the right CIDR")
			assert.False(subnet1.Get("privateIpGoogleAccess").Bool(), "should not have Private Google Access")
			assert.False(subnet1.Get("logConfig.enable").Bool(), "logConfig should not be enabled")

			subnet2 := gcloud.Run(t, "compute networks subnets describe subnet-02", gcOpts)
			assert.Equal("10.10.20.0/24", subnet2.Get("ipCidrRange").String(), "should have the right CIDR")
			assert.True(subnet2.Get("privateIpGoogleAccess").Bool(), "should have Private Google Access")
			expectedLogConfig := `{"aggregationInterval": "INTERVAL_5_SEC","enable": true,"filterExpr": "true","flowSampling": 0.5,"metadata": "INCLUDE_ALL_METADATA"}`
			assert.JSONEq(expectedLogConfig, subnet2.Get("logConfig").String(), "Default log config should be correct")

			subnet3 := gcloud.Run(t, "compute networks subnets describe subnet-03", gcOpts)
			assert.Equal("10.10.30.0/24", subnet3.Get("ipCidrRange").String(), "should have the right CIDR")
			assert.False(subnet3.Get("privateIpGoogleAccess").Bool(), "should not have Private Google Access")
			expectedLogConfig = `{"aggregationInterval": "INTERVAL_10_MIN","enable": true,"filterExpr": "true","flowSampling": 0.7,"metadata": "INCLUDE_ALL_METADATA"}`
			assert.JSONEq(expectedLogConfig, subnet3.Get("logConfig").String(), "log config should be correct")
		})
	net.Test()
}
