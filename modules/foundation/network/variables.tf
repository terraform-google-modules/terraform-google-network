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
  description = "Project ID for Shared VPC."
  type        = string
}

variable "resource_codes" {
  description = "codes for resources created"
  type = object({
    short = optional(string, "p")
    long  = optional(string, "production")
  })
}

variable "vpc_name" {
  description = "The name of the network being created. Complete name will be `vpc-{vpc_name}`"
  type        = string
}

variable "subnets" {
  description = "The list of subnets being created"
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = string
    subnet_private_access            = optional(string, "false")
    subnet_private_ipv6_access       = optional(string)
    subnet_flow_logs                 = optional(string, "false")
    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")
    subnet_flow_logs_sampling        = optional(string, "0.5")
    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")
    subnet_flow_logs_filter          = optional(string, "true")
    subnet_flow_logs_metadata_fields = optional(list(string), [])
    description                      = optional(string)
    purpose                          = optional(string)
    role                             = optional(string)
    stack_type                       = optional(string)
    ipv6_access_type                 = optional(string)
  }))
  default = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}

variable "nat_config" {
  description = "Configuration of NAT cloud router."
  type = object({
    enabled = optional(bool, false)
    bgp_asn = optional(number, 64512)
    regions = optional(list(object({
      name          = string
      num_addresses = optional(number, 2)
    })))
  })
  default = {}
}

variable "windows_activation_enabled" {
  description = "Enable Windows license activation for Windows workloads. See https://docs.cloud.google.com/compute/docs/instances/windows/creating-managing-windows-instances ."
  type        = bool
  default     = false
}

variable "private_service_cidr" {
  description = "CIDR range for private service networking. Used for Cloud SQL and other managed services."
  type        = string
  default     = null
}

variable "private_service_connect_ip" {
  description = "The subnet internal IP to be used as the private service connect endpoint in the Shared VPC"
  type        = string
}

variable "firewall_enable_logging" {
  description = "Toggle firewall logging for VPC Firewalls."
  type        = bool
  default     = true
}

variable "enable_all_vpc_internal_traffic" {
  description = "Enable firewall policy rule to allow internal traffic (ingress and egress)."
  type        = bool
  default     = false
}

variable "dns_config" {
  description = "DNS configuration."
  type = object({
    enable_logging               = optional(bool, true)
    onprem_forwarding            = optional(bool, false)
    enable_inbound_forwarding    = optional(bool, true)
    dns_hub_project_id           = optional(string, "")
    dns_hub_network_name         = optional(string, "")
    domain                       = optional(string, "")
    type                         = optional(string, "")
    target_name_server_addresses = optional(list(map(any)), [])
  })
  default = {}

  validation {
    condition = var.dns_config.onprem_forwarding == false || (
      var.dns_config.type == "spoke" ? (
        var.dns_config.dns_hub_project_id != "" &&
        var.dns_config.dns_hub_network_name != ""
        ) : (
        var.dns_config.domain != "" &&
        length(var.dns_config.target_name_server_addresses) > 0
      )
    )
    error_message = "When 'onprem_forwarding' is true: If type is 'spoke', 'dns_hub_project_id' and 'dns_hub_network_name' are required. If type is not spoke, 'domain' and 'target_name_server_addresses' are required."
  }
}

variable "ncc_hub_config" {
  description = "Network Connectivity Center configuration."
  type = object({
    create_hub                     = optional(bool, true)
    uri                            = optional(string)
    name                           = optional(string)
    description                    = optional(string)
    hub_labels                     = optional(map(string))
    policy_mode                    = optional(string, "PRESET")
    preset_topology                = optional(string, "MESH")
    export_psc                     = optional(bool, false)
    spoke_labels                   = optional(map(string))
    spoke_exclude_export_ranges    = optional(set(string), [])
    spoke_include_export_ranges    = optional(set(string), [])
    spoke_description              = optional(string)
    spoke_group                    = optional(string, "default")
    producer_labels                = optional(map(string))
    producer_exclude_export_ranges = optional(set(string), [])
    producer_include_export_ranges = optional(set(string), [])
    producer_description           = optional(string)
    auto_accept_projects_center    = optional(list(string), [])
    auto_accept_projects_edge      = optional(list(string), [])
    auto_accept_projects_default   = optional(list(string), [])
  })

  default = {}

  validation {
    condition = (
      (
        var.ncc_hub_config.create_hub == true &&
        var.ncc_hub_config.name != null &&
        var.ncc_hub_config.description != null &&
        var.ncc_hub_config.hub_labels != null &&
        var.ncc_hub_config.preset_topology != null
      )
      ||
      (
        var.ncc_hub_config.create_hub == false &&
        var.ncc_hub_config.uri != null
      )
    )
    error_message = "Invalid NCC Hub configuration. If create_hub is TRUE: name, description, labels, and preset_topology are required. If create_hub is FALSE: uri is required."
  }
}
