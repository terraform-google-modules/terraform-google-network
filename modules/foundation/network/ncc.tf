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
  is_star = var.ncc_hub_config.create_hub && var.ncc_hub_config.preset_topology == "STAR"
  is_mesh = var.ncc_hub_config.create_hub && var.ncc_hub_config.preset_topology == "MESH"
}

module "network_connectivity_center" {
  source = "../../network-connectivity-center"

  hub_configuration = {
    create       = var.ncc_hub_config.create_hub
    existing_uri = var.ncc_hub_config.uri
  }

  project_id              = var.project_id
  ncc_hub_name            = var.ncc_hub_config.name
  ncc_hub_description     = var.ncc_hub_config.description
  ncc_hub_policy_mode     = var.ncc_hub_config.policy_mode
  ncc_hub_preset_topology = var.ncc_hub_config.preset_topology
  ncc_hub_labels          = var.ncc_hub_config.hub_labels
  export_psc              = var.ncc_hub_config.export_psc

  vpc_spokes = {
    "vpc" = merge(
      {
        uri                   = module.main.network_id
        exclude_export_ranges = var.ncc_hub_config.spoke_exclude_export_ranges
        include_export_ranges = var.ncc_hub_config.spoke_include_export_ranges
        description           = var.ncc_hub_config.spoke_description
        labels                = var.ncc_hub_config.spoke_labels
        group                 = var.ncc_hub_config.spoke_group
      },
      var.private_service_cidr != null ? {
        link_producer_vpc_network = {
          network_name          = module.main.network_name
          peering               = google_service_networking_connection.private_vpc_connection[0].peering
          exclude_export_ranges = var.ncc_hub_config.producer_exclude_export_ranges
          include_export_ranges = var.ncc_hub_config.producer_include_export_ranges
          description           = var.ncc_hub_config.producer_description
          labels                = var.ncc_hub_config.producer_labels
          group                 = var.ncc_hub_config.spoke_group
        }
      } : {}
    )
  }

  ncc_groups = merge(
    local.is_star ? {
      center = {
        name                 = "center"
        auto_accept_projects = var.ncc_hub_config.auto_accept_projects_center
      }
      edge = {
        name                 = "edge"
        auto_accept_projects = var.ncc_hub_config.auto_accept_projects_edge
      }
    } : {},
    local.is_mesh ? {
      default = {
        name                 = "default"
        auto_accept_projects = var.ncc_hub_config.auto_accept_projects_default
      }
    } : {}
  )

}
