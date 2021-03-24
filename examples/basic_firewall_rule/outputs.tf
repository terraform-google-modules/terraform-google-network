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

output "name" {
  value       = google_compute_firewall.rules.name
  description = "The name of the firewall rule being created"
}

output "network_name" {
  value       = google_compute_firewall.rules.network
  description = "The name of the VPC network where the firewall rule will be applied"
}

output "rule_self_link" {
  value       = google_compute_firewall.rules.self_link
  description = "The URI of the firewall rule  being created"
}

output "project_id" {
  value       = google_compute_firewall.rules.project
  description = "Google Cloud project ID"
}
