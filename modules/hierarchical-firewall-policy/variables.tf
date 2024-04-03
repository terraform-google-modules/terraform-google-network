/**
 * Copyright 2023 Google LLC
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

variable "parent_node" {
  description = "The parent of the firewall policy. Parent should be in format organizations/<org-id> or folders/<folder_id>"
  type        = string
}

variable "policy_name" {
  description = "User-provided name of the hierarchical firewall policy"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,62}$", var.policy_name))
    error_message = "User-provided name of the Organization firewall policy. The name should be unique in the organization in which the firewall policy is created. The name must be 1-63 characters long and match the regular expression a-z? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash"
  }
}

variable "description" {
  description = "An optional description of this resource. Provide this property when you create the resource"
  type        = string
  default     = null
}

variable "target_folders" {
  description = "List of target folders IDs that the firewall policy will be attached to"
  type        = list(string)
  default     = []
}

variable "target_org" {
  description = "Target org id that the firewall policy will be attached to"
  type        = string
  default     = null
}

variable "rules" {
  description = "List of Ingress/Egress rules"
  type = list(object({
    priority                = number
    direction               = string
    action                  = string
    rule_name               = optional(string)
    disabled                = optional(bool)
    description             = optional(string)
    enable_logging          = optional(bool)
    target_service_accounts = optional(list(string), [])
    target_resources        = optional(list(string), [])
    match = object({
      src_ip_ranges             = optional(list(string), [])
      src_fqdns                 = optional(list(string), [])
      src_region_codes          = optional(list(string), [])
      src_threat_intelligences  = optional(list(string), [])
      src_address_groups        = optional(list(string), [])
      dest_ip_ranges            = optional(list(string), [])
      dest_fqdns                = optional(list(string), [])
      dest_region_codes         = optional(list(string), [])
      dest_threat_intelligences = optional(list(string), [])
      dest_address_groups       = optional(list(string), [])
      layer4_configs = optional(list(object({
        ip_protocol = optional(string, "all")
        ports       = optional(list(string), [])
      })), [{}])
    })
  }))
  default = []
}
