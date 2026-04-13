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

resource "google_network_connectivity_service_connection_policy" "service_connection_policies" {
  for_each      = var.service_connection_policies
  project       = each.value.network_project
  name          = each.key
  location      = var.location
  service_class = var.service_class
  description   = lookup(each.value, "description", null)
  network       = "projects/${each.value.network_project}/global/networks/${each.value.network_name}"
  labels        = each.value.labels

  psc_config {
    subnetworks = [
      for x in each.value.subnet_names :
      "projects/${each.value.network_project}/regions/${var.location}/subnetworks/${x}"
    ]
    limit = lookup(each.value, "limit", null)
  }

  depends_on = [module.enable_apis]
}

module "enable_apis" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 18.0"

  project_id  = var.project_id
  enable_apis = var.enable_apis

  disable_services_on_destroy = false
  disable_dependent_services  = false

  activate_apis = var.activate_apis
}
