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
    auto_create_subnetworks                    = google_compute_network.network.auto_create_subnetworks
    bgp_always_compare_med                     = google_compute_network.network.bgp_always_compare_med
    bgp_best_path_selection_mode               = google_compute_network.network.bgp_best_path_selection_mode
    bgp_inter_region_cost                      = google_compute_network.network.bgp_inter_region_cost
    delete_bgp_always_compare_med              = google_compute_network.network.delete_bgp_always_compare_med
    delete_default_routes_on_create            = google_compute_network.network.delete_default_routes_on_create
    deletion_policy                            = google_compute_network.network.deletion_policy
    description                                = google_compute_network.network.description
    enable_ula_internal_ipv6                   = google_compute_network.network.enable_ula_internal_ipv6
    gateway_ipv4                               = google_compute_network.network.gateway_ipv4
    id                                         = google_compute_network.network.id
    internal_ipv6_range                        = google_compute_network.network.internal_ipv6_range
    mtu                                        = google_compute_network.network.mtu
    name                                       = google_compute_network.network.name
    network_firewall_policy_enforcement_order  = google_compute_network.network.network_firewall_policy_enforcement_order
    network_id                                 = google_compute_network.network.network_id
    network_profile                            = google_compute_network.network.network_profile
    project                                    = google_compute_network.network.project
    routing_mode                               = google_compute_network.network.routing_mode
    self_link                                  = google_compute_network.network.self_link
  }
  description = "The VPC resource being created"
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
