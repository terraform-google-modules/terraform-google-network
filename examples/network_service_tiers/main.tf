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

# [START networkservicetiers_vm_create]
resource "google_compute_instance" "vm" {
  project      = var.project_id # Replace this with your project ID in quotes
  zone         = "us-east4-c"
  name         = "my-standard-tier-instance"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}
# [END networkservicetiers_vm_create]

# [START networkservicetiers_target_instance_create]
resource "google_compute_target_instance" "target" {
  project  = var.project_id # Replace this with your project ID in quotes
  name     = "target"
  zone     = "us-east4-c"
  instance = google_compute_instance.vm.id
}
# [END networkservicetiers_target_instance_create]

# [START networkservicetiers_forwarding_rule_create]
resource "google_compute_forwarding_rule" "target-fr" {
  project      = var.project_id # Replace this with your project ID in quotes
  name         = "target-instance-forwarding-rule"
  region       = "us-east4"
  target       = google_compute_target_instance.target.id
  port_range   = "80"
  network_tier = "STANDARD"
}
# [END networkservicetiers_forwarding_rule_create]

# [START networkservicetiers_instance_template_create]
resource "google_compute_instance_template" "template" {
  project      = var.project_id # Replace this with your project ID in quotes
  name         = "template"
  machine_type = "e2-medium"
  disk {
    source_image = "debian-cloud/debian-10"
    boot         = true
  }
  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}
# [END networkservicetiers_instance_template_create]
