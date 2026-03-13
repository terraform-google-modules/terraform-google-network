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

output "service_connection_policies" {
  description = "Service Connection Policies created."
  value       = google_network_connectivity_service_connection_policy.service_connection_policies
}

output "service_connection_policy_ids" {
  description = "IDs of the created Service Connection Policies."
  value = {
    for name, policy in google_network_connectivity_service_connection_policy.service_connection_policies :
    name => policy.id
  }
}
