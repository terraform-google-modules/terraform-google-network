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

output "project" {
  value       = google_compute_shared_vpc_host_project.host.project
  description = "Host project ID"
}

output "ip_address_name" {
  value       = google_compute_address.internal.name
  description = "The name of the internal IP"
}

output "subnet" {
  value       = google_compute_address.internal.subnetwork
  description = "Name of the host subnet"
}

output "ip_address" {
  value       = google_compute_address.internal.address
  description = "The internal IP address"
}
