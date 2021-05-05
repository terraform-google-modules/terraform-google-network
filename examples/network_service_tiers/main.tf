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

terraform {
  required_providers {
    google = {
      version = ">= 3.45.0"
    }
    null = {
      version = ">= 2.1.0"
    }
  }
}

# [START networkservicetiers_project_tier_set]
resource "google_compute_project_default_network_tier" "project-tier" {
  project      = var.project_id # Replace this with your project ID in quotes
  network_tier = "STANDARD"
}
# [END networkservicetiers_project_tier_set]

# [START networkservicetiers_address_create]
resource "google_compute_address" "ip-address" {
  project      = var.project_id # Replace this with your project ID in quotes
  name         = "my-standard-tier-ip-address"
  region       = "us-central1"
  network_tier = "STANDARD"
}
# [END networkservicetiers_address_create]
