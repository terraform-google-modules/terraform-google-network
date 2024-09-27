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
  description = "Project ID of the project that holds the network."
  type        = string
}

variable "ncc_hub_name" {
  description = "The Name of the NCC Hub"
  type        = string
}

variable "ncc_hub_description" {
  description = "The description of the NCC Hub"
  type        = string
  default     = null
}
variable "ncc_hub_labels" {
  description = "These labels will be added the NCC hub"
  type        = map(string)
  default     = {}
}

variable "export_psc" {
  description = "Whether Private Service Connect transitivity is enabled for the hub"
  type        = bool
  default     = false
}

variable "vpc_spokes" {
  description = "VPC network that is associated with the spoke"
  type = map(object({
    uri                   = string
    exclude_export_ranges = optional(set(string), [])
    include_export_ranges = optional(set(string), [])
    description           = optional(string)
    labels                = optional(map(string))
  }))
  default = {}
}

variable "hybrid_spokes" {
  description = "VLAN attachments and VPN Tunnels that are associated with the spoke. Type must be one of `interconnect` and `vpn`."
  type = map(object({
    location                   = string
    uris                       = set(string)
    site_to_site_data_transfer = optional(bool, false)
    type                       = string
    description                = optional(string)
    labels                     = optional(map(string))
  }))
  default = {}
}

variable "router_appliance_spokes" {
  description = "Router appliance instances that are associated with the spoke."
  type = map(object({
    instances = set(object({
      virtual_machine = string
      ip_address      = string
    }))
    location                   = string
    site_to_site_data_transfer = optional(bool, false)
    description                = optional(string)
    labels                     = optional(map(string))
  }))
  default = {}
}

variable "spoke_labels" {
  description = "These labels will be added to all NCC spokes"
  type        = map(string)
  default     = {}
}
