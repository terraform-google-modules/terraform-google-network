/**
 * Copyright 2022 Google LLC
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

# Whenever a new major version of the network module is released, the
# version constraint below should be updated, e.g. to ~> 4.0.
#
# If that new version includes provider updates, validation of this
# example may fail until that is done.

module "private_service_connect" {
  source                     = "../../modules/private-service-connect"
  project_id                 = var.project_id
  network_self_link          = module.simple_vpc.network_self_link
  private_service_connect_ip = "10.3.0.5"
  forwarding_rule_target     = "all-apis"
}

module "simple_vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 7.0"
  project_id   = var.project_id
  network_name = "my-custom-network"
  mtu          = 1460

  subnets = [
    {
      subnet_name           = "my-subnetwork"
      subnet_ip             = "10.0.0.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]
}
