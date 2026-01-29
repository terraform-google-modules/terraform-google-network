// Copyright 2022 Google LLC
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

package private_service_connect_producer_ipv4

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestPrivateServiceConnectProducerIpv4(t *testing.T) {
	producer := tft.NewTFBlueprintTest(t)

	producer.DefineVerify(func(assert *assert.Assertions) {
		producer.DefaultVerify(assert)
		projectID := producer.GetStringOutput("project_id")
		gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-east1", "--format", "json"})

		subnet1 := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s-nat-subnet-0", producer.GetStringOutput("service_attachment_name")), gcOpts)
		assert.Regexp("[a-z0-9\\.]+\\/24", subnet1.Get("ipCidrRange").String(), "subnet should have the right IPv4 CIDR")

		serviceAttachment := gcloud.Run(t, fmt.Sprintf("compute service-attachments describe %s", producer.GetStringOutput("service_attachment_name")), gcOpts)
		assert.Equal(1, len(serviceAttachment.Get("natSubnets").Array()), "should have two nat subnets")
		assert.Equal("ACCEPT_MANUAL", serviceAttachment.Get("connectionPreference").String(), "should be accept_manual")
		assert.Equal("[\n    {\n      \"connectionLimit\": 10,\n      \"projectIdOrNum\": \"978556359090\"\n    }\n  ]", serviceAttachment.Get("consumerAcceptLists").String(), "Wrong accept lists")
		assert.Equal("[\n    \"712633635622\"\n  ]", serviceAttachment.Get("consumerRejectLists").String(), "Wrong reject lists")
	})
	producer.Test()
}
