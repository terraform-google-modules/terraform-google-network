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

output "project_id" {
  value       = var.project_id
  description = "The project id"
}

output "address_name" {
  value       = module.private-service-connect-endpoint.address_name
  description = "Private Service Connect address name."
}

output "ip_address" {
  value       = module.private-service-connect-endpoint.ip_address
  description = "Private Service Connect IP address."
}

output "address_id" {
  value       = module.private-service-connect-endpoint.address_id
  description = "An identifier for the address created for the private service connect with format projects/{$project}/regions/{$region}/addresses/{$name}."
}

output "forwarding_rule_name" {
  value       = module.private-service-connect-endpoint.forwarding_rule_name
  description = "Private Service Connect forwarding rule resource name."
}
