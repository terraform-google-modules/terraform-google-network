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

resource "google_compute_global_address" "global_addresses" {
  for_each      = { for address in var.global_addresses : address.name => address }
  project       = var.project_id
  name          = each.value.name
  purpose       = each.value.purpose
  address_type  = each.value.type
  address       = each.value.address
  prefix_length = each.value.prefix_length
  network       = "projects/${var.project_id}/global/networks/${var.network_name}"
}

resource "google_service_networking_connection" "default" {
  network                 = "projects/${var.project_id}/global/networks/${var.network_name}"
  service                 = var.service
  reserved_peering_ranges = [for name, _ in google_compute_global_address.global_addresses : name]
  deletion_policy         = var.deletion_policy
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  count                = var.create_peering_routes_config ? 1 : 0
  project              = var.project_id
  peering              = google_service_networking_connection.default.peering
  network              = var.network_name
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}

resource "google_service_networking_peered_dns_domain" "default" {
  count      = var.create_peered_dns_domain ? 1 : 0
  project    = var.project_id
  name       = var.domain_name
  network    = var.network_name
  dns_suffix = var.dns_suffix
  service    = var.service
}
