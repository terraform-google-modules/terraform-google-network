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

variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
}

variable "network_name" {
  description = "Name of the network this set of firewall rules applies to."
  type        = string
}

variable "rules" {
  description = "List of custom rule definitions"
  default     = []
  type = list(object({
    name                    = string
    description             = optional(string, null)
    direction               = optional(string, "INGRESS")
    priority                = optional(number, null)
    ranges                  = optional(list(string), [])
    destination_ranges      = optional(list(string), [])
    source_ranges           = optional(list(string), [])
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    log_config = optional(object({
      metadata = string
    }))
  }))
  validation {
    condition = alltrue(
      [for v in var.rules : !((length(coalesce(v.destination_ranges, [])) > 0 || length(coalesce(v.source_ranges, [])) > 0) && length(coalesce(v.ranges, [])) > 0)]
    )
    error_message = "ranges may not be set at the same time as destination_ranges OR source_ranges"
  }
}
