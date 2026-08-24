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

output "project_id_hub" {
  value       = module.example.project_id_hub
  description = "The ID of the project being used"
}

output "project_id_spoke" {
  value       = module.example.project_id_spoke
  description = "The ID of the project being used"
}

output "hub_network_name" {
  value       = module.example.hub_network_name
  description = "The name of the VPC being created"
}

output "hub_network_self_link" {
  value       = module.example.hub_network_self_link
  description = "The URI of the VPC being created"
}

output "hub_subnets_names" {
  value       = module.example.hub_subnets_names
  description = "The names of the subnets being created"
}

output "hub_subnets_ips" {
  value       = module.example.hub_subnets_ips
  description = "The IP and cidrs of the subnets being created"
}

output "hub_subnets_regions" {
  value       = module.example.hub_subnets_regions
  description = "The region where subnets will be created"
}

output "hub_subnets_private_access" {
  value       = module.example.hub_subnets_private_access
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "hub_subnets_flow_logs" {
  value       = module.example.hub_subnets_flow_logs
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "hub_subnets_secondary_ranges" {
  value       = module.example.hub_subnets_secondary_ranges
  description = "The secondary ranges associated with these subnets"
}

output "hub_routes" {
  value       = module.example.hub_route_names
  description = "The route names associated with this VPC"
}

output "spoke_network_name" {
  value       = module.example.spoke_network_name
  description = "The name of the VPC being created"
}

output "spoke_network_self_link" {
  value       = module.example.spoke_network_self_link
  description = "The URI of the VPC being created"
}

output "spoke_subnets_names" {
  value       = module.example.spoke_subnets_names
  description = "The names of the subnets being created"
}

output "spoke_subnets_ips" {
  value       = module.example.spoke_subnets_ips
  description = "The IP and cidrs of the subnets being created"
}

output "spoke_subnets_regions" {
  value       = module.example.spoke_subnets_regions
  description = "The region where subnets will be created"
}

output "spoke_subnets_private_access" {
  value       = module.example.spoke_subnets_private_access
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "spoke_subnets_flow_logs" {
  value       = module.example.spoke_subnets_flow_logs
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "spoke_subnets_secondary_ranges" {
  value       = module.example.spoke_subnets_secondary_ranges
  description = "The secondary ranges associated with these subnets"
}

output "spoke_routes" {
  value       = module.example.spoke_route_names
  description = "The route names associated with this VPC"
}

output "ncc_hub_uri" {
  value       = module.example.ncc_hub_uri
  description = "The NCC Hub ID"
}
