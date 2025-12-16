/**
 * Copyright 2021 Google LLC
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

output "service_attachment_name" {
  description = "Name of the service attachment"
  value       = google_compute_service_attachment.default.name
}

output "service_attachment_self_link" {
  description = "Self link of the service attachment"
  value       = google_compute_service_attachment.default.self_link
}

output "service_attachment_id" {
  description = "ID of the service attachment"
  value       = google_compute_service_attachment.default.id
}

output "nat_subnets" {
  description = "The NAT Subnets"
  value       = google_compute_subnetwork.subnetworks
}
