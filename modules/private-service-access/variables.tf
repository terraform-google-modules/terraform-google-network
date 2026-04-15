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

variable "project_id" {
  description = "The project ID of the VPC network."
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network (e.g., google_compute_network.vpc.id)."
  type        = string
}

variable "address_name" {
  description = "The name of the reserved IP range."
  type        = string
  default     = "private-ip-address"
}

variable "prefix_length" {
  description = "The prefix length of the reserved IP range."
  type        = number
  default     = 16
}
