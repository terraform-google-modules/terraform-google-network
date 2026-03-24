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
  default_region1 = "us-central1"
  default_region2 = "us-west1"

  subnet_primary_ranges = {
    (local.default_region1) = "10.8.0.0/18"
    (local.default_region2) = "10.9.0.0/18"
  }
  subnet_proxy_ranges = {
    (local.default_region1) = "10.26.0.0/23"
    (local.default_region2) = "10.27.0.0/23"
  }
}

module "main" {
  source = "../../../../modules/foundation/network"

  project_id                      = var.project_id
  vpc_name                        = var.network_name
  private_service_connect_ip      = "10.17.0.5"
  private_service_cidr            = "10.16.40.0/21"
  enable_all_vpc_internal_traffic = false

  resource_codes = {
    short = "c"
    long  = "common"
  }

  ncc_hub_config = {
    create_hub                   = true
    description                  = "common"
    export_psc                   = true
    name                         = "common"
    auto_accept_projects_default = [var.project_id]

    hub_labels = {
      type = "common"
    }
    spoke_labels = {
      type = "common_vpc"
    }

  }

  subnets = [
    {
      subnet_name   = "sb-c-svpc-${local.default_region1}"
      subnet_ip     = local.subnet_primary_ranges[local.default_region1]
      subnet_region = local.default_region1
      description   = "Network subnet for ${local.default_region1}"
    },
    {
      subnet_name   = "sb-c-svpc-${local.default_region2}"
      subnet_ip     = local.subnet_primary_ranges[local.default_region2]
      subnet_region = local.default_region2
      description   = "Network subnet for ${local.default_region2}"
    },
    {
      subnet_name           = "sb-c-svpc-${local.default_region1}-proxy"
      subnet_ip             = local.subnet_proxy_ranges[local.default_region1]
      subnet_region         = local.default_region1
      subnet_flow_logs      = false
      subnet_private_access = false
      description           = "Network proxy-only subnet for ${local.default_region1}"
      role                  = "ACTIVE"
      purpose               = "REGIONAL_MANAGED_PROXY"
    },
    {
      subnet_name           = "sb-c-svpc-${local.default_region2}-proxy"
      subnet_ip             = local.subnet_proxy_ranges[local.default_region2]
      subnet_region         = local.default_region2
      subnet_flow_logs      = false
      subnet_private_access = false
      description           = "Network proxy-only subnet for ${local.default_region2}"
      role                  = "ACTIVE"
      purpose               = "REGIONAL_MANAGED_PROXY"
    }
  ]
}
