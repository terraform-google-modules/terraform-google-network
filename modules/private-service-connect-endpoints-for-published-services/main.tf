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

resource "google_compute_address" "private_service_connect_regional_address" {
  project      = var.project_id
  region       = var.region
  name         = var.address_name
  subnetwork   = var.subnetwork
  address_type = "INTERNAL"
  ip_version   = var.ip_version
  address      = var.ip_address
}

resource "google_compute_forwarding_rule" "private_service_connect_for_published_services" {
  project                 = var.project_id
  region                  = var.region
  name                    = var.forwarding_rule_name
  target                  = var.forwarding_rule_target
  network                 = var.network
  ip_address              = google_compute_address.private_service_connect_regional_address.id
  allow_psc_global_access = var.psc_global_access
  load_balancing_scheme   = ""

  // Currently, only supports a single Service Directory resource
  dynamic "service_directory_registrations" {
    for_each = var.service_directory_namespace != null ? [1] : []

    content {
      namespace = var.service_directory_namespace
    }
  }
}
