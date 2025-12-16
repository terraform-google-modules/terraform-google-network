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

package private_service_connect_producer_ipv6

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestPrivateServiceConnectProducerIpv6(t *testing.T) {
	producer := tft.NewTFBlueprintTest(t)

	producer.DefineVerify(func(assert *assert.Assertions) {
		producer.DefaultVerify(assert)
		projectID := producer.GetStringOutput("project_id")
		gcOpts := gcloud.WithCommonArgs([]string{"--project", projectID, "--region", "us-east1", "--format", "json"})

		subnet1 := gcloud.Run(t, fmt.Sprintf("compute networks subnets describe %s-nat-subnet-0", producer.GetStringOutput("service_attachment_name")), gcOpts)
		assert.Regexp("[a-z0-9\\:]+\\/64", subnet1.Get("internalIpv6Prefix").String(), "subnet should have the right IPv6 CIDR")

		serviceAttachment := gcloud.Run(t, fmt.Sprintf("compute service-attachments describe %s", producer.GetStringOutput("service_attachment_name")), gcOpts)
		assert.Equal(1, len(serviceAttachment.Get("natSubnets").Array()), "should have one nat subnet")
		assert.Equal("ACCEPT_AUTOMATIC", serviceAttachment.Get("connectionPreference").String(), "should be accept_automatic")
	})
	producer.Test()
}
