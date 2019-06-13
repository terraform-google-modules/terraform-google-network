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
  subnet_01 = "${var.network_name}-subnet-01"
  subnet_02 = "${var.network_name}-subnet-02"
}

module "test-vpc-module" {
  source       = "../../"
  project_id   = "${var.project_id}"
  network_name = "${var.network_name}"

  subnets = [
    {
      subnet_name   = "${local.subnet_01}"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "${local.subnet_02}"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  routes = [
    {
      destination_range = "10.10.12.0/24"
      network_name      = "${local.subnet_01}"
      next_hop_ip       = "10.10.10.1"
      priority          = 100
    },
    {
      destination_range = "10.10.22.0/24"
      network_name      = "${local.subnet_02}"
      next_hop_ip       = "10.10.20.1"
      priority          = 100
    }
  ]

  secondary_ranges = {
    "${local.subnet_01}" = []
    "${local.subnet_02}" = []
  }
}
