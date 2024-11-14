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
  vpc_spokes = {
    for k, v in google_network_connectivity_spoke.vpc_spoke :
    k => v
  }
  hybrid_spokes = {
    for k, v in google_network_connectivity_spoke.hybrid_spoke :
    k => v
  }
  router_appliance_spokes = {
    for k, v in google_network_connectivity_spoke.router_appliance_spoke :
    k => v
  }
}

resource "google_network_connectivity_hub" "hub" {
  name        = var.ncc_hub_name
  project     = var.project_id
  description = var.ncc_hub_description
  export_psc  = var.export_psc
  labels      = var.ncc_hub_labels
}


resource "google_network_connectivity_spoke" "vpc_spoke" {
  for_each    = var.vpc_spokes
  project     = split("/", each.value.uri)[1]
  name        = each.key
  location    = "global"
  description = each.value.description
  hub         = google_network_connectivity_hub.hub.id
  labels      = merge(var.spoke_labels, each.value.labels)

  linked_vpc_network {
    uri                   = each.value.uri
    exclude_export_ranges = each.value.exclude_export_ranges
    include_export_ranges = each.value.include_export_ranges
  }
}

resource "google_network_connectivity_spoke" "hybrid_spoke" {
  for_each    = var.hybrid_spokes
  project     = var.project_id
  name        = each.key
  location    = each.value.location
  description = each.value.description
  hub         = google_network_connectivity_hub.hub.id
  labels      = merge(var.spoke_labels, each.value.labels)

  dynamic "linked_interconnect_attachments" {
    for_each = each.value.type == "interconnect" ? [1] : []
    content {
      uris                       = each.value.uris
      site_to_site_data_transfer = each.value.site_to_site_data_transfer
    }
  }

  dynamic "linked_vpn_tunnels" {
    for_each = each.value.type == "vpn" ? [1] : []
    content {
      uris                       = each.value.uris
      site_to_site_data_transfer = each.value.site_to_site_data_transfer
    }
  }
}

resource "google_network_connectivity_spoke" "router_appliance_spoke" {
  for_each    = var.router_appliance_spokes
  project     = var.project_id
  name        = each.key
  location    = each.value.location
  description = each.value.description
  hub         = google_network_connectivity_hub.hub.id
  labels      = merge(var.spoke_labels, each.value.labels)

  linked_router_appliance_instances {
    dynamic "instances" {
      for_each = each.value.instances
      iterator = instance_list
      content {
        virtual_machine = instance_list.value.virtual_machine
        ip_address      = instance_list.value.ip_address
      }
    }
    site_to_site_data_transfer = each.value.site_to_site_data_transfer

  }
}
