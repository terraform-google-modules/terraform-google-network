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

# Whenever a new major version of the network module is released, the
# version constraint below should be updated, e.g. to ~> 4.0.
#
# If that new version includes provider updates, validation of this
# example may fail until that is done.

locals {
  producer_network_name   = "producer-net"
  producer_subnet_name    = "producer-subnet"
  service_attachment_name = "producer-sa"

  consumer_network_name = "consumer-net"
  consumer_subnet_name  = "consumer-subnet"
}

# Producer-side resources; created by the service producer.
resource "google_compute_network" "producer_network" {
  project                 = var.private_service_connect_producer_project_id
  name                    = local.producer_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "producer_subnetwork" {
  project       = var.private_service_connect_producer_project_id
  name          = local.producer_subnet_name
  network       = google_compute_network.producer_network.self_link
  stack_type    = "IPV4_ONLY"
  ip_cidr_range = "10.1.2.0/24"
  region        = var.region
}

module "test-ilb" {
  source  = "GoogleCloudPlatform/lb-internal/google"
  version = "~> 7.0"

  project     = var.private_service_connect_producer_project_id
  network     = google_compute_network.producer_network.name
  subnetwork  = google_compute_subnetwork.producer_subnetwork.name
  region      = var.region
  name        = "producer-lb"
  ports       = ["8080"]
  source_tags = ["allow-group1"]
  target_tags = ["allow-group2", "allow-group3"]
  backends    = []
  health_check = {
    type                = "http"
    check_interval_sec  = 1
    healthy_threshold   = 4
    timeout_sec         = 1
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 8081
    port_name           = "health-check-port"
    request             = ""
    request_path        = "/"
    host                = "1.2.3.4"
    enable_log          = false
  }
  depends_on = [google_compute_network.producer_network, google_compute_subnetwork.producer_subnetwork]
}

module "service-attachment" {
  source  = "terraform-google-modules/network/google//modules/private-service-connect-producer"
  version = "~> 15.0"

  project_id = var.private_service_connect_producer_project_id
  network    = google_compute_network.producer_network.name
  name       = local.service_attachment_name

  region                = var.region
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets = [{
    ipv4_range = "10.10.20.0/24"
  }]
  target_service = module.test-ilb.forwarding_rule_id
}
# End of producer-side resources.

# Consumer-side resources; created by the user of private_service_connect module.
resource "google_compute_network" "consumer_network" {
  project                 = var.project_id
  name                    = local.consumer_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "consumer_subnetwork" {
  project       = var.project_id
  name          = local.consumer_subnet_name
  network       = google_compute_network.consumer_network.self_link
  stack_type    = "IPV4_ONLY"
  ip_cidr_range = "10.1.0.0/24"
  region        = var.region
}

module "private-service-connect-endpoint" {
  source  = "terraform-google-modules/network/google//modules/private-service-connect-endpoints-for-published-services"
  version = "~> 15.0"

  project_id         = var.project_id
  region             = var.region
  network            = google_compute_network.consumer_network.name
  subnetwork         = google_compute_subnetwork.consumer_subnetwork.name
  service_attachment = module.service-attachment.service_attachment_id

  depends_on = [google_compute_subnetwork.consumer_subnetwork]
}
# End of consumer-side resources
