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

module "vpc-secondary-ranges" {
  source       = "../../"
  project_id   = "${var.project_id}"
  network_name = "${local.network_name}"

  subnets = [
    {
      subnet_name   = "secondary-ranges-subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "secondary-ranges-subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name   = "secondary-ranges-subnet-03"
      subnet_ip     = "10.10.30.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    secondary-ranges-subnet-01 = [
      {
        range_name    = "subnet-01-01"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "subnet-01-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]

    secondary-ranges-subnet-02 = []

    secondary-ranges-subnet-03 = [
      {
        range_name    = "subnet-03-01"
        ip_cidr_range = "192.168.66.0/24"
      },
    ]
  }
}
