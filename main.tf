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

locals {
  network_self_link = var.create_network ? google_compute_network.network[0].self_link : data.google_compute_network.network[0].self_link
  network_name      = var.create_network ? google_compute_network.network[0].name : data.google_compute_network.network[0].name
}

/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "network" {
  count                   = var.create_network ? 1 : 0
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project                 = var.project_id
  description             = var.description
}

data "google_compute_network" "network" {
  count   = var.create_network ? 0 : 1
  name    = var.network_name
  project = var.project_id
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count   = var.shared_vpc_host == "true" ? 1 : 0
  project = var.project_id
}

/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  count = length(var.subnets)

  name                     = var.subnets[count.index]["subnet_name"]
  ip_cidr_range            = var.subnets[count.index]["subnet_ip"]
  region                   = var.subnets[count.index]["subnet_region"]
  private_ip_google_access = lookup(var.subnets[count.index], "subnet_private_access", "true")
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  network                  = local.network_self_link
  project                  = var.project_id
  secondary_ip_range       = [for i in range(length(contains(keys(var.secondary_ranges), var.subnets[count.index]["subnet_name"]) == true ? var.secondary_ranges[var.subnets[count.index]["subnet_name"]] : [])) : var.secondary_ranges[var.subnets[count.index]["subnet_name"]][i]]
  description              = lookup(var.subnets[count.index], "description", null)
  depends_on               = [google_compute_network.network]
}

data "google_compute_subnetwork" "created_subnets" {
  count   = length(var.subnets)
  name    = element(google_compute_subnetwork.subnetwork.*.name, count.index)
  region  = element(google_compute_subnetwork.subnetwork.*.region, count.index)
  project = var.project_id
}

/******************************************
	Routes
 *****************************************/
resource "google_compute_route" "route" {
  count                  = length(var.routes)
  project                = var.project_id
  network                = local.network_name
  name                   = lookup(var.routes[count.index], "name", format("%s-%s-%d", lower(local.network_name), "route", count.index))
  description            = lookup(var.routes[count.index], "description", "")
  tags                   = compact(split(",", lookup(var.routes[count.index], "tags", "")))
  dest_range             = lookup(var.routes[count.index], "destination_range", "")
  next_hop_gateway       = lookup(var.routes[count.index], "next_hop_internet", "false") == "true" ? "default-internet-gateway" : ""
  next_hop_ip            = lookup(var.routes[count.index], "next_hop_ip", "")
  next_hop_instance      = lookup(var.routes[count.index], "next_hop_instance", "")
  next_hop_instance_zone = lookup(var.routes[count.index], "next_hop_instance_zone", "")
  next_hop_vpn_tunnel    = lookup(var.routes[count.index], "next_hop_vpn_tunnel", "")
  priority               = lookup(var.routes[count.index], "priority", "1000")

  depends_on = [
    google_compute_subnetwork.subnetwork,
  ]
}

resource "null_resource" "delete_default_internet_gateway_routes" {
  count = var.delete_default_internet_gateway_routes ? 1 : 0

  provisioner "local-exec" {
    command = "${path.module}/scripts/delete-default-gateway-routes.sh ${var.project_id} ${local.network_name}"
  }

  triggers = {
    number_of_routes = length(var.routes)
  }

  depends_on = [
    google_compute_network.network,
    google_compute_subnetwork.subnetwork,
    google_compute_route.route,
  ]
}

resource "google_compute_firewall" "deny-egress-all" {
  name = "deny-egress-all"
  network = google_compute_network.network.name
  allow {
    protocol = "all"
  }
}