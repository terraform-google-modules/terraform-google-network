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

/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                  = "./modules/vpc"
  network_name            = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project_id              = var.project_id
  description             = var.description
  shared_vpc_host         = var.shared_vpc_host
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "./modules/subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name
  subnets          = var.subnets
  description      = var.description
  secondary_ranges = var.secondary_ranges
}

/******************************************
	Routes
 *****************************************/
resource "google_compute_route" "route" {
  count                  = length(var.routes)
  project                = var.project_id
  network                = var.network_name
  name                   = lookup(var.routes[count.index], "name", format("%s-%s-%d", lower(var.network_name), "route", count.index))
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
    module.vpc.network,
    module.subnets.subnets,
  ]
}

resource "null_resource" "delete_default_internet_gateway_routes" {
  count = var.delete_default_internet_gateway_routes ? 1 : 0

  provisioner "local-exec" {
    command = "${path.module}/scripts/delete-default-gateway-routes.sh ${var.project_id} ${var.network_name}"
  }

  triggers = {
    number_of_routes = length(var.routes)
  }

  depends_on = [
    module.vpc.network,
    module.subnets.subnets,
    google_compute_route.route,
  ]
}
