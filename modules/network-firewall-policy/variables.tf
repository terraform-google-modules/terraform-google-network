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

variable "project_id" {
  description = "Project ID of the Network firewall policy"
  type        = string
}

variable "policy_name" {
  description = "User-provided name of the Network firewall policy"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,62}$", var.policy_name))
    error_message = "The name must be 1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the regular expression a-z? which means the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash"
  }
}

variable "description" {
  description = "An optional description of this resource. Provide this property when you create the resource"
  type        = string
  default     = null
}

variable "target_vpcs" {
  description = "List of target VPC IDs that the firewall policy will be attached to"
  type        = list(string)
  default     = []
}

variable "policy_region" {
  description = "Location of the firewall policy. Needed for regional firewall policies. Default is null (Global firewall policy)"
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
    target_secure_tags      = optional(list(string))
    target_service_accounts = optional(list(string), [])
    match = object({
      src_ip_ranges             = optional(list(string), [])
      src_fqdns                 = optional(list(string), [])
      src_region_codes          = optional(list(string), [])
      src_secure_tags           = optional(list(string), [])
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
  validation {
    condition = alltrue(
      [for v in var.rules : !(length(coalesce(v.target_secure_tags, [])) > 0 && length(coalesce(v.target_service_accounts, [])) > 0)]
    )
    error_message = "target_secure_tags may not be set at the same time as target_service_accounts"
  }

}
