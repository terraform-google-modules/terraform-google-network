/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  network_name = "test-network-${random_string.random_suffix.result}"
}

resource "random_string" "random_suffix" {
  length  = 4
  upper   = "false"
  special = "false"
}

module "test-vpc-module" {
  source                                 = "../../"
  project_id                             = "${var.project_id}"
  network_name                           = "${local.network_name}"
  delete_default_internet_gateway_routes = "true"

  subnets = [
    {
      subnet_name   = "subnet-41"
      subnet_ip     = "10.20.30.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    subnet-41 = []
  }
}
