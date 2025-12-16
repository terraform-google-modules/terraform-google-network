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
  network_name = "producer-net"
  subnet_name  = "producer-subnet"
}

# Producer-side resources; created by the service producer.
resource "google_compute_network" "producer_network" {
  project                 = var.project_id
  name                    = local.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "producer_subnetwork" {
  project       = var.project_id
  name          = local.subnet_name
  network       = google_compute_network.producer_network.self_link
  stack_type    = "IPV4_ONLY"
  ip_cidr_range = "10.1.2.0/24"
  region        = var.region
}

module "test_ilb" {
  source  = "GoogleCloudPlatform/lb-internal/google"
  version = "~> 7.0"

  project     = var.project_id
  network     = google_compute_network.producer_network.name
  subnetwork  = local.subnet_name
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
  depends_on = [google_compute_subnetwork.producer_subnetwork]
}

module "test_service_attachment" {
  source = "terraform-google-modules/network/google//modules/private-service-connect-producer"

  project_id = var.project_id
  network    = google_compute_network.producer_network.name
  name       = "producer-sa"

  region                = var.region
  connection_preference = "ACCEPT_MANUAL"
  consumer_accept_lists = [
    {
      project_id_or_num = var.accepted_project
      connection_limit  = 10
    },
  ]
  consumer_reject_lists = [var.rejected_project]
  nat_subnets = [{
    ipv4_range = "10.10.20.0/24"
  }]
  target_service = module.test_ilb.forwarding_rule_id
  depends_on     = [module.test_ilb]
}
