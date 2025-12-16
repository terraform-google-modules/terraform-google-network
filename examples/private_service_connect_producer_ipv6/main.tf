/**
 * Copyright 2021 Google LLC
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
  network_name         = "ipv6-producer-net"
  subnet_name          = "dual-stack-producer-subnet"
  backend_service_name = "ipv6-test-be"
  ilb_name             = "ipv6-test-ilb"
}
resource "google_compute_network" "producer_network" {
  project                  = var.project_id
  name                     = local.network_name
  auto_create_subnetworks  = false
  enable_ula_internal_ipv6 = true
}

resource "google_compute_subnetwork" "producer_fr_subnetwork" {
  project          = var.project_id
  name             = local.subnet_name
  network          = google_compute_network.producer_network.name
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "INTERNAL"
  ip_cidr_range    = "10.1.0.0/24"
  region           = var.region
}

resource "google_compute_region_backend_service" "producer_backend_service" {
  project               = var.project_id
  name                  = local.backend_service_name
  load_balancing_scheme = "INTERNAL"
  protocol              = "TCP"
  region                = var.region
}

resource "google_compute_forwarding_rule" "producer_forwarding_rule" {
  project               = var.project_id
  name                  = local.ilb_name
  network               = google_compute_network.producer_network.name
  subnetwork            = google_compute_subnetwork.producer_fr_subnetwork.name
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  backend_service       = google_compute_region_backend_service.producer_backend_service.id
  ip_version            = "IPV6"
  region                = var.region
}

module "test_service_attachment" {
  source = "terraform-google-modules/network/google//modules/private-service-connect-producer"

  project_id = var.project_id
  network    = google_compute_network.producer_network.name
  name       = "ipv6-producer-sa"

  region                = var.region
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets = [{
    stack_type = "IPV6_ONLY"
  }]
  target_service = google_compute_forwarding_rule.producer_forwarding_rule.id
}
