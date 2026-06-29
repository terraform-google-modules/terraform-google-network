/**
 * Copyright 2025 Google LLC
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

output "network" {
  value = {
    id                      = google_compute_network.network.id
    name                    = google_compute_network.network.name
    project                 = google_compute_network.network.project
    self_link               = google_compute_network.network.self_link
    gateway_ipv4            = google_compute_network.network.gateway_ipv4
    routing_mode            = google_compute_network.network.routing_mode
    auto_create_subnetworks = google_compute_network.network.auto_create_subnetworks
    description             = google_compute_network.network.description
    mtu                     = google_compute_network.network.mtu
    network_id              = google_compute_network.network.network_id
    numeric_id              = google_compute_network.network.network_id
  }
  description = "Selected attributes of the VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}

output "network_unique_id" {
  value       = google_compute_network.network.network_id
  description = "The unique identifier for the resource, defined by the server"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

output "project_id" {
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0 ? google_compute_shared_vpc_host_project.shared_vpc_host[0].project : google_compute_network.network.project
  description = "VPC project id"
}
