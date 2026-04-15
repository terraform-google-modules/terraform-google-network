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

output "network_name" {
  description = "The name of the VPC being created"
  value       = module.test-vpc-private-access.network_name
}

output "project_id" {
  description = "VPC project id"
  value       = var.project_id
}

output "subnets_ips" {
  description = "The IPs and CIDRs of the subnets being created"
  value       = module.test-vpc-private-access.subnets_ips
}
