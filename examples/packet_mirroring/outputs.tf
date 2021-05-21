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


output "packet_mirror" {
  value       = google_compute_packet_mirroring.default.name
  description = "The name of the packet mirroring policy"
}

output "collector_ilb" {
  value       = google_compute_packet_mirroring.default.collector_ilb[0].url
  description = "The internal load balancer"
}

output "instance" {
  value       = google_compute_packet_mirroring.default.mirrored_resources[0].instances[0].url
  description = "The VM instance"
}
