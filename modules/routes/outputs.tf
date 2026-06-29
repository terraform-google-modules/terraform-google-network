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

output "routes" {
  value       = values(google_compute_route.route)
  description = "The created routes resources"
}

output "route_ids" {
  value       = [for r in google_compute_route.route : r.id]
  description = "The IDs of the created routes."
}

output "route_names" {
  value       = [for r in google_compute_route.route : r.name]
  description = "The names of the created routes."
}
