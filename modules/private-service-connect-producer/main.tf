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

resource "google_compute_service_attachment" "default" {
  project               = var.project_id
  name                  = var.name
  region                = var.region
  nat_subnets           = [for subnet in google_compute_subnetwork.subnetworks : subnet.self_link]
  connection_preference = var.connection_preference
  dynamic "consumer_accept_lists" {
    for_each = var.consumer_accept_lists
    content {
      project_id_or_num = consumer_accept_lists.value["project_id_or_num"]
      network_url       = consumer_accept_lists.value["network_url"]
      connection_limit  = consumer_accept_lists.value["connection_limit"]
    }
  }
  consumer_reject_lists       = var.consumer_reject_lists
  reconcile_connections       = var.reconcile_connections
  enable_proxy_protocol       = var.enable_proxy_protocol
  propagated_connection_limit = var.propagated_connection_limit
  target_service              = var.target_service
  domain_names                = var.domain_names
}

resource "google_compute_subnetwork" "subnetworks" {
  for_each = {
    for index, value in var.nat_subnets :
    (value.subnet_name == null) ? "${var.name}-nat-subnet-${index}" : value.subnet_name => value
  }
  project          = var.network_project_id == null ? var.project_id : var.network_project_id
  network          = var.network
  region           = var.region
  name             = each.key
  ip_cidr_range    = each.value.ipv4_range
  ipv6_access_type = (each.value.stack_type == "IPV4_IPV6" || each.value.stack_type == "IPV6_ONLY") ? "INTERNAL" : null
  stack_type       = each.value.stack_type
  purpose          = "PRIVATE_SERVICE_CONNECT"
}
