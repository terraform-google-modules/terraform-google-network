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
  description = "The ID of the project being used."
  value       = var.project_id
}

output "prefix" {
  description = "The name prefix being used."
  value       = var.prefix
}

output "local_network_name" {
  description = "Local network name."
  value       = var.local_network_name
}

output "peer_network_name" {
  description = "Peer network name."
  value       = var.peer_network_name
}
