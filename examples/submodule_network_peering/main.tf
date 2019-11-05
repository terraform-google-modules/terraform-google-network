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
  source       = "../../"
  project_id   = var.project_id
  network_name = var.local_network_name

  subnets = [
    {
      subnet_name   = "subnet1"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    }
  ]
}

module "peer-network" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.peer_network_name

  subnets = [
    {
      subnet_name   = "subnet2"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "us-west1"
    }
  ]
}

module "peering" {
  source        = "../../modules/network-peering"
  local_network = module.local-network.network_self_link
  peer_network  = module.peer-network.network_self_link
}
