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

resource "google_compute_network" "default" {
  project                 = var.project_id # Replace this with your project ID in quotes
  name                    = "new-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  project       = google_compute_network.default.project
  name          = "my-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = "new-network"
}

resource "google_compute_instance" "mirror" {
  project      = google_compute_network.default.project
  zone         = "us-central1-a"
  name         = "my-instance"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {
    }
  }
}

resource "google_compute_health_check" "default" {
  project            = google_compute_network.default.project
  name               = "my-healthcheck"
  check_interval_sec = 1
  timeout_sec        = 1
  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_region_backend_service" "default" {
  project       = google_compute_network.default.project
  region        = "us-central1"
  name          = "my-service"
  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_forwarding_rule" "default" {
  name                   = "my-ilb"
  project                = google_compute_network.default.project
  region                 = "us-central1"
  is_mirroring_collector = true
  ip_protocol            = "TCP"
  load_balancing_scheme  = "INTERNAL"
  backend_service        = google_compute_region_backend_service.default.id
  all_ports              = true
  network                = google_compute_network.default.id
  subnetwork             = google_compute_subnetwork.default.id
  network_tier           = "PREMIUM"
}

# [START compute_vm_packet_mirror]
resource "google_compute_packet_mirroring" "default" {
  project     = google_compute_network.default.project # Replace this with a reference to your project ID
  region      = "us-central1"
  name        = "my-mirroring"
  description = "My packet mirror"
  network {
    url = google_compute_network.default.id # Replace this with a reference to your VPC network
  }
  collector_ilb {
    url = google_compute_forwarding_rule.default.id # Replace this with a reference to your forwarding rule
  }
  mirrored_resources {
    tags = ["foo"]
    instances {
      url = google_compute_instance.mirror.id # Replace this with a reference to your VM instance
    }
  }
  filter {
    ip_protocols = ["tcp"]
    cidr_ranges  = ["0.0.0.0/0"]
    direction    = "BOTH"
  }
}
# [END compute_vm_packet_mirror]
