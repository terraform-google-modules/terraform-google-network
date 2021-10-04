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
