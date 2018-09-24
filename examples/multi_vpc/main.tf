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

module "test-vpc-module-01" {
  source       = "../../"
  project_id   = "${var.project_id}"
  network_name = "test-network-01"

  subnets = [
    {
      subnet_name           = "test-network-01-subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "test-network-01-subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "test-network-01-subnet-03"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    test-network-01-subnet-01 = [
      {
        range_name    = "test-network-01-subnet-01-01"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "test-network-01-subnet-01-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]

    test-network-01-subnet-02 = [
      {
        range_name    = "test-network-01-subnet-02-01"
        ip_cidr_range = "192.168.74.0/24"
      },
    ]

    test-network-01-subnet-03 = []
  }
}

module "test-vpc-module-02" {
  source       = "../../"
  project_id   = "${var.project_id}"
  network_name = "test-network-02"

  subnets = [
    {
      subnet_name           = "test-network-02-subnet-01"
      subnet_ip             = "10.10.40.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "test-network-02-subnet-02"
      subnet_ip             = "10.10.50.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    test-network-02-subnet-01 = [
      {
        range_name    = "est-network-02-subnet-02-01"
        ip_cidr_range = "192.168.75.0/24"
      },
    ]

    test-network-02-subnet-02 = []
  }
}
