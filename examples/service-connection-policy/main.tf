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

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 13.1"

  project_id   = var.project_id
  network_name = "example-vpc"

  subnets = [
    {
      subnet_name   = "psc-subnet"
      subnet_ip     = "10.10.0.0/24"
      subnet_region = var.region
    }
  ]
}

module "service_connection_policy" {
  source = "terraform-google-modules/network/google//modules/service-connection-policy"

  project_id    = var.project_id
  name          = "example-scp"
  location      = var.region
  network       = module.network.network_self_link
  service_class = var.service_class

  subnetworks = [module.network.subnets_self_links[0]]
  labels      = { env = "dev" }
}
