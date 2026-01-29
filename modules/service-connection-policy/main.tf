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

resource "google_network_connectivity_service_connection_policy" "this" {
  project       = var.project_id
  name          = var.name
  location      = var.location
  network       = var.network
  service_class = var.service_class
  description   = var.description
  labels        = var.labels

  psc_config {
    subnetworks = var.subnetworks
    limit       = var.limit
  }
}
