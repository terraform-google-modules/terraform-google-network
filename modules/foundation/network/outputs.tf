
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

output "network" {
  value       = module.main.network
  description = "The created network"
}

output "subnets" {
  value       = module.main.subnets
  description = "A map with keys of form subnet_region/subnet_name and values being the outputs of the google_compute_subnetwork resources used to create corresponding subnets."
}

output "network_name" {
  value       = module.main.network_name
  description = "The name of the VPC being created"
}

output "project_id" {
  value       = module.main.project_id
  description = "VPC project id"
}

output "dns_policy" {
  value       = google_dns_policy.default_policy.name
  description = "The name of the DNS policy being created"
}

output "network_self_link" {
  value       = module.main.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets_names" {
  value       = module.main.subnets_names
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = module.main.subnets_ips
  description = "The IPs and CIDRs of the subnets being created"
}

output "subnets_self_links" {
  value       = module.main.subnets_self_links
  description = "The self-links of subnets being created"
}

output "subnets_regions" {
  value       = module.main.subnets_regions
  description = "The region where the subnets will be created"
}

output "subnets_secondary_ranges" {
  value       = module.main.subnets_secondary_ranges
  description = "The secondary ranges associated with these subnets"
}

output "firewall_policy" {
  value       = module.firewall_rules.fw_policy
  description = "Policy created for firewall policy rules."
}

output "ncc_hub_uri" {
  value       = module.network_connectivity_center.ncc_hub_id
  description = "The NCC Hub ID"
}

output "subnets_private_access" {
  value       = module.main.subnets_private_access
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "subnets_flow_logs" {
  value       = module.main.subnets_flow_logs
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "route_names" {
  value       = module.main.route_names
  description = "The route names associated with this VPC"
}
