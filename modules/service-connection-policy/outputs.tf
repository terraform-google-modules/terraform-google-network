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

output "id" {
  description = "The resource ID of the created Service Connection Policy."
  value       = google_network_connectivity_service_connection_policy.this.id
}

output "name" {
  description = "The name of the created Service Connection Policy."
  value       = google_network_connectivity_service_connection_policy.this.name
}

output "location" {
  description = "The region of the created Service Connection Policy."
  value       = google_network_connectivity_service_connection_policy.this.location
}

output "network" {
  description = "The VPC network attached to the policy."
  value       = google_network_connectivity_service_connection_policy.this.network
}

output "service_class" {
  description = "The service class attached to the policy."
  value       = google_network_connectivity_service_connection_policy.this.service_class
}
