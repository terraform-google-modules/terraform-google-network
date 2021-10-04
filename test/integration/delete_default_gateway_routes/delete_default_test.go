package routes

import (
	"fmt"
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestDeleteDefaultGatewayRoutes(t *testing.T) {
	net := tft.NewTFBlueprintTest(t)
	net.DefineVerify(
		func(assert *assert.Assertions) {
			net.DefaultVerify(assert)
			projectID := net.GetStringOutput("project_id")
			filter := fmt.Sprintf("nextHopGateway:https://www.googleapis.com/compute/v1/projects/%s/global/gateways/default-internet-gateway AND network:https://www.googleapis.com/compute/v1/projects/%s/global/networks/%s", projectID, projectID, net.GetStringOutput("network_name"))

			op := gcloud.Run(t, "compute routes list", gcloud.WithCommonArgs([]string{"--project", projectID, "--filter", filter, "--format", "json"}))
			assert.Equal(1, len(op.Array()), "should only be one")
			assert.False(strings.HasPrefix(op.Array()[0].Get("name").String(), "default-route"), "should not begin with default-route")
		})
	net.Test()
}
