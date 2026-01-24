/**
 * Copyright 2026 Google LLC
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
  mode                        = var.mode == null ? "" : var.mode == "hub" ? "-hub" : "-spoke"
  network_name                = "vpc-${var.vpc_name}${local.mode}"
  restricted_googleapis_cidr  = module.private_service_connect.private_service_connect_ip
  google_forward_source_range = "35.199.192.0/19"

}

/******************************************
  Shared VPC configuration
 *****************************************/

module "main" {
  source  = "terraform-google-modules/network/google"
  version = "~> 13.0"

  project_id                             = var.project_id
  network_name                           = local.network_name
  shared_vpc_host                        = "true"
  delete_default_internet_gateway_routes = "true"

  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges

  routes = concat(
    var.nat_config.enabled ?
    [
      {
        name              = "rt-${var.vpc_name}-1000-egress-internet-default"
        description       = "Tag based route through IGW to access internet"
        destination_range = "0.0.0.0/0"
        tags              = "egress-internet"
        next_hop_internet = "true"
        priority          = "1000"
      }
    ]
    : [],
    var.windows_activation_enabled ?
    [
      {
        name              = "rt-${var.vpc_name}-1000-all-default-windows-kms"
        description       = "Route through IGW to allow Windows KMS activation for GCP."
        destination_range = "35.190.247.13/32"
        next_hop_internet = "true"
        priority          = "1000"
      }
    ]
    : []
  )
}
