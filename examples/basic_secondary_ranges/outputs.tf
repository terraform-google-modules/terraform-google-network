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

output "project_id" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.project
  description = "Google Cloud project ID"
}

output "region" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
  description = "Google Cloud region"
}

output "subnetwork_name" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
  description = "The name of the subnetwork"
}

output "primary_cidr" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.ip_cidr_range
  description = "Primary CIDR range"
}

output "secondary_cidr_name" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.secondary_ip_range[0].range_name
  description = "Name of the secondary CIDR range"
}

output "secondary_cidr" {
  value       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.secondary_ip_range[0].ip_cidr_range
  description = "Secondary CIDR range"
}
