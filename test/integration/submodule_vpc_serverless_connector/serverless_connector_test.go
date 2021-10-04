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
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			gcOps := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-central1", "--format", "json"})

			connector := gcloud.Run(t, "beta compute networks vpc-access connectors describe central-serverless", gcOps)
			assert.Equal("e2-standard-4", connector.Get("machineType").String(), "should have correct machinetype")
			assert.Equal("serverless-subnet", connector.Get("subnet.name").String(), "should have correct subnet")
		})
	net.Test()
}
