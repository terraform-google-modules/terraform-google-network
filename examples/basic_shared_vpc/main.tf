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


provider "null" {
  version = "~> 2.1"
}

provider "google" {
  version = "~> 3.45.0"
}

# [START vpc_shared_vpc_host_project_enable]
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project # Replace this with your host project ID in quotes
}
# [END vpc_shared_vpc_host_project_enable]

# [START vpc_shared_vpc_service_project_attach]
resource "google_compute_shared_vpc_service_project" "service1" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project # Replace this with your service project ID in quotes
}
# [END vpc_shared_vpc_service_project_attach]

# [START compute_shared_data]
data "google_compute_subnetwork" "subnet" {
  name    = "my-subnet-123"
  project = var.project
  region  = "us-central1"
}
# [END compute_shared_data]

# [START compute_shared_internal_ip_create]
resource "google_compute_address" "internal" {
  project      = var.service_project
  region       = "us-central1"
  name         = "int-ip"
  address_type = "INTERNAL"
  address      = "10.0.0.8"
  subnetwork   = data.google_compute_subnetwork.subnet.self_link
}
# [END compute_shared_internal_ip_create]

# [START compute_shared_instance_with_reserved_ip_create]
resource "google_compute_instance" "reserved_ip" {
  project      = var.service_project
  zone         = "us-central1-a"
  name         = google_compute_address.internal.self_link
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
    network_ip = "int-ip"
  }
}
# [END compute_shared_instance_with_reserved_ip_create]

# [START compute_shared_instance_with_ephemeral_ip_create]
resource "google_compute_instance" "ephemeral_ip" {
  project      = var.service_project
  zone         = "us-central1-a"
  name         = "my-vm"
  machine_type = "e2-medium"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
  }
}
# [END compute_shared_instance_with_ephemeral_ip_create]


# [START compute_shared_instance_template_create]
resource "google_compute_instance_template" "default" {
  project      = var.service_project
  name         = "appserver-template"
  description  = "This template is used to create app server instances."
  machine_type = "n1-standard-1"
  disk {
    source_image = "debian-cloud/debian-9"
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
  }
}
# [END compute_shared_instance_template_create]
