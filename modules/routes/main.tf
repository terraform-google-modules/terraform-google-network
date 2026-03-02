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
  routes = {
    for i, route in var.routes :
    lookup(route, "name", format("%s-%s-%d", lower(var.network_name), "route", i)) => route
  }
}

/******************************************
	Routes
 *****************************************/
resource "google_compute_route" "route" {
  for_each = local.routes

  project = var.project_id
  network = var.network_name

  name                   = each.key
  description            = each.value.description
  tags                   = each.value.tags
  dest_range             = each.value.destination_range
  next_hop_gateway       = each.value.next_hop_internet ? "default-internet-gateway" : each.value.next_hop_gateway
  next_hop_ip            = each.value.next_hop_ip
  next_hop_instance      = each.value.next_hop_instance
  next_hop_instance_zone = each.value.next_hop_instance_zone
  next_hop_vpn_tunnel    = each.value.next_hop_vpn_tunnel
  next_hop_ilb           = each.value.next_hop_ilb
  priority               = each.value.priority

  depends_on = [var.module_depends_on]
}
