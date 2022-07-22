/**
 * Copyright 2022 Google LLC
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

output "private_service_connect_name" {
  value       = google_compute_global_address.private_service_connect.name
  description = "Private service connect name"

  depends_on = [
    google_compute_global_forwarding_rule.forwarding_rule_private_service_connect
  ]
}

output "private_service_connect_ip" {
  value       = google_compute_global_address.private_service_connect.address
  description = "Private service connect ip"

  depends_on = [
    google_compute_global_forwarding_rule.forwarding_rule_private_service_connect
  ]
}

output "global_address_id" {
  value       = google_compute_global_address.private_service_connect.id
  description = "An identifier for the global address created for the private service connect with format `projects/{{project}}/global/addresses/{{name}}`"
}

output "forwarding_rule_name" {
  value       = google_compute_global_forwarding_rule.forwarding_rule_private_service_connect.name
  description = "Forwarding rule resource name."
}

output "forwarding_rule_target" {
  value       = google_compute_global_forwarding_rule.forwarding_rule_private_service_connect.target
  description = "Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid."
}

output "dns_zone_googleapis_name" {
  value       = module.googleapis.name
  description = "Name for Managed DNS zone for GoogleAPIs"
}

output "dns_zone_gcr_name" {
  value       = module.gcr.name
  description = "Name for Managed DNS zone for GCR"
}

output "dns_zone_pkg_dev_name" {
  value       = module.pkg_dev.name
  description = "Name for Managed DNS zone for PKG_DEV"
}
