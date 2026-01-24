/**
 * Copyright 2026 Google LLC
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
  Default DNS Policy
 *****************************************/

resource "google_dns_policy" "default_policy" {
  project                   = var.project_id
  name                      = "dp-${var.resource_codes.short}-svpc-default-policy"
  enable_logging            = var.dns_config.enable_logging
  enable_inbound_forwarding = var.dns_config.onprem_forwarding ? var.dns_config.enable_inbound_forwarding : false
  networks {
    network_url = module.main.network_self_link
  }
}

/******************************************
 Creates DNS Peering to DNS HUB
*****************************************/

data "google_compute_network" "vpc_dns_hub" {
  count = var.dns_config.onprem_forwarding && var.mode == "spoke" ? 1 : 0

  name    = var.dns_config.dns_hub_network_name
  project = var.dns_config.dns_hub_project_id
}

module "peering_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "~> 6.1"

  count = var.dns_config.onprem_forwarding && var.mode == "spoke" ? 1 : 0

  project_id  = var.project_id
  type        = "peering"
  name        = "dz-${var.resource_codes.short}-svpc-to-dns-hub"
  domain      = var.dns_config.domain
  description = "Private DNS peering zone."

  private_visibility_config_networks = [
    module.main.network_self_link
  ]
  target_network = data.google_compute_network.vpc_dns_hub[0].self_link
}

/******************************************
 DNS Forwarding
*****************************************/
module "dns_forwarding_zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "~> 6.1"

  count = var.dns_config.onprem_forwarding && var.mode != "spoke" ? 1 : 0

  project_id = var.project_id
  type       = "forwarding"
  name       = "fz-dns-hub"
  domain     = var.dns_config.domain

  private_visibility_config_networks = [
    module.main.network_self_link
  ]
  target_name_server_addresses = var.dns_config.target_name_server_addresses
}
