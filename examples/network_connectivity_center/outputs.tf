/**
 * Copyright 2024 Google LLC
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

output "project_id" {
  description = "The project ID (required for testing)"
  value       = var.project_id
}

output "ncc_hub_name" {
  description = "Name of the NCC Hub (required for testing)"
  value       = element(reverse(split("/", module.network_connectivity_center.ncc_hub.name)), 0)
}

output "vpc_spokes" {
  description = "All vpc spoke objects"
  value       = module.network_connectivity_center.vpc_spokes
}


output "hybrid_spokes" {
  description = "All hybrid spoke objects"
  value       = module.network_connectivity_center.hybrid_spokes
}

output "router_appliance_spokes" {
  description = "All router appliance spoke objects"
  value       = module.network_connectivity_center.router_appliance_spokes
}

output "spokes" {
  description = "All spoke objects prefixed with the type of spoke (vpc, hybrid, appliance)"
  value       = module.network_connectivity_center.spokes
}
