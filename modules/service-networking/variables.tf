/**
 * Copyright 2024 Google LLC
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
  description = "Project ID"
  type        = string
}

variable "global_addresses" {
  description = "List of global addresses to be created"
  type = list(object({
    name : string,
    purpose : optional(string, "VPC_PEERING"),
    type : optional(string, "INTERNAL"),
    prefix_length : optional(number, 16)
  }))
}

variable "network" {
  description = "Network details including name and id"
  type = object({
    name = optional(string, null),
    id   = string
  })
}

variable "service" {
  description = "Service to create service networking connection"
  type        = string
}

variable "deletion_policy" {
  description = "Deletion policy for service networking resource"
  type        = string
  default     = null
}

variable "create_peering_routes_config" {
  description = "Create peering route config"
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Import custom routes to peering rout config"
  type        = bool
  default     = false
}

variable "export_custom_routes" {
  description = "Export custom routes"
  type        = bool
  default     = false
}

variable "create_peered_dns_domain" {
  description = "Create peered dns domain"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = null
}

variable "dns_suffix" {
  description = "Dns suffix"
  type        = string
  default     = null
}
