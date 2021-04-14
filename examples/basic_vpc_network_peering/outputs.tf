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

output "peering1_name" {
  value       = google_compute_network_peering.peering1.name
  description = "The name of the the first VPC network"
}

output "peering2_name" {
  value       = google_compute_network_peering.peering2.name
  description = "The name of the the second VPC network"
}

output "project_id" {
  value       = google_compute_network.default.project
  description = "VPC project id"
}
