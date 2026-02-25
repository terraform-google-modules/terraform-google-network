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

variable "project_id" {
  description = "The project ID where APIs will be enabled (when enable_apis is true)."
  type        = string
}

variable "location" {
  description = "Region where the Service Connection Policies will be created (e.g., us-east4)."
  type        = string
}

variable "service_class" {
  description = "Service class of the managed service to enable PSC for (see product docs for valid values)."
  type        = string
}

variable "enable_apis" {
  description = "Whether to enable required APIs in the project."
  type        = bool
  default     = true
}

variable "activate_apis" {
  description = "APIs to enable when enable_apis is true."
  type        = list(string)
  default = [
    "networkconnectivity.googleapis.com",
    "compute.googleapis.com",
  ]
}

variable "service_connection_policies" {
  description = "The Service Connection Policies to create."
  type = map(object({
    description     = optional(string)
    network_name    = string
    network_project = string
    subnet_names    = list(string)
    limit           = optional(number)
    labels          = optional(map(string), {})
  }))
  default = {}
}
