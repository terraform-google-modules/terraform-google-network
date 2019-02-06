/**
 * Copyright 2018 Google LLC
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
  value       = "${var.project_id}"
  description = "The ID of the project being used"
}

output "network_01_name" {
  value       = "${module.example.network_01_name}"
  description = "The name of the VPC network-01"
}

output "network_01_routes" {
  value       = "${module.example.network_01_routes}"
  description = "The routes associated with network-01"
}

output "network_01_route_data" {
  value       = "${module.example.network_01_route_data}"
  description = "The route data for network 01 that was passed into the network module"
}

output "network_02_name" {
  value       = "${module.example.network_02_name}"
  description = "The name of the VPC network-02"
}

output "network_02_routes" {
  value       = "${module.example.network_02_routes}"
  description = "The routes associated with network-02"
}

output "network_02_route_data" {
  value       = "${module.example.network_02_route_data}"
  description = "The route data for network 02 that was passed into the network module"
}
