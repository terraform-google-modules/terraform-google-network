/**
 * Copyright 2019 Google LLC
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

module "local-network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 10.0"

  project_id   = var.project_id
  network_name = "local-network"
  subnets      = []
}

module "peer-network-1" {
  source  = "terraform-google-modules/network/google"
  version = "~> 10.0"

  project_id   = var.project_id
  network_name = "peer-network-1"
  subnets      = []
}

module "peer-network-2" {
  source  = "terraform-google-modules/network/google"
  version = "~> 10.0"

  project_id   = var.project_id
  network_name = "peer-network-2"
  subnets      = []
}

module "peering-1" {
  source  = "terraform-google-modules/network/google//modules/network-peering"
  version = "~> 10.0"

  local_network              = module.local-network.network_self_link
  peer_network               = module.peer-network-1.network_self_link
  export_local_custom_routes = true
}

module "peering-2" {
  source  = "terraform-google-modules/network/google//modules/network-peering"
  version = "~> 10.0"

  local_network              = module.local-network.network_self_link
  peer_network               = module.peer-network-2.network_self_link
  export_local_custom_routes = true

  module_depends_on = [module.peering-1.complete]
}
