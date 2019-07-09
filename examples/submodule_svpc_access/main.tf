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

locals {
  first_gce_sa  = "serviceAccount:${var.service_project_number_first_subnet}-compute@developer.gserviceaccount.com"
  second_gce_sa = "serviceAccount:${var.service_project_number_multi_subnet}-compute@developer.gserviceaccount.com"
}

module "net-vpc-shared" {
  source          = "../../"
  project_id      = var.host_project_id
  network_name    = var.network_name
  shared_vpc_host = "true"

  subnets = [
    {
      subnet_name   = "first"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    },
    {
      subnet_name   = "second"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "europe-west1"
    },
  ]

  secondary_ranges = {
    first  = []
    second = []
  }
}

module "net-svpc-access" {
  source              = "../../modules/fabric-net-svpc-access"
  host_project_id     = module.net-vpc-shared.svpc_host_project_id
  service_project_num = 1
  service_project_ids = var.service_project_id_full_access
  host_subnets        = module.net-vpc-shared.subnets_names
  host_subnet_regions = module.net-vpc-shared.subnets_regions

  host_subnet_users = {
    first  = "${local.first_gce_sa},${local.second_gce_sa}"
    second = local.second_gce_sa
  }
}
