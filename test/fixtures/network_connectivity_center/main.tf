/**
 * Copyright 2024 Google LLC
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
  ncc_hub_name              = "ncc-hub-${var.random_string_for_testing}"
  vpc_spoke_vpc_name        = "vpc-spoke-${var.random_string_for_testing}"
  vpn_spoke_local_vpc_name  = "vpn-local-spoke-${var.random_string_for_testing}"
  vpn_spoke_remote_vpc_name = "vpn-remote-spoke-${var.random_string_for_testing}"
  router_appliance_vpc_name = "router-appliance-spoke-${var.random_string_for_testing}"
}

module "example" {
  source                    = "../../../examples/network_connectivity_center"
  project_id                = var.project_id
  ncc_hub_name              = local.ncc_hub_name
  vpc_spoke_vpc_name        = local.vpc_spoke_vpc_name
  vpn_spoke_local_vpc_name  = local.vpn_spoke_local_vpc_name
  vpn_spoke_remote_vpc_name = local.vpn_spoke_remote_vpc_name
  router_appliance_vpc_name = local.router_appliance_vpc_name
}
