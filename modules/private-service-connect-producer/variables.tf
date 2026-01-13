/**
 * Copyright 2021 Google LLC
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

variable "name" {
  description = "Name for the service attachment."
  type        = string
}

variable "project_id" {
  description = "The project to deploy to, if not set the default provider project is used."
  type        = string
}

variable "region" {
  description = "Region for cloud resources."
  type        = string
}

variable "network" {
  description = "Name, id or self link of the network to create resources in."
  type        = string
}

variable "network_project_id" {
  description = "(Optional) Name of the project for the Shared VPC host network, in which the NAT subnets will be created. Required for Shared VPC case."
  type        = string
  default     = null
}

variable "nat_subnets" {
  description = <<EOT
  NAT Subnets.
  - subnet_name: (Optional) Name of the subnet. Defaults to `$var.name-nat-subnet-$index` if unset.
  - ipv4_range: (Optional) IPv4 range is required for IPV4_ONLY and IPV4_IPV6 stack type. Leave ipv4_range unset for IPV6_ONLY subnet.
  - stack_type: (Optional) IPV4_ONLY, IPV4_IPV6 or IPV6_ONLY. IPv6 range is assigned by GCP.
EOT
  type = list(object({
    subnet_name = optional(string)
    ipv4_range  = optional(string)
    stack_type  = optional(string)
  }))
}

variable "domain_names" {
  description = "(Optional) The domain names to be used during the integration between the PSC connected endpoints and the Cloud DNS."
  type        = list(string)
  default     = null
}

variable "target_service" {
  description = "Target service URL ex. ILB, SWP. Supported types: https://cloud.google.com/vpc/docs/configure-private-service-connect-producer#lb-types "
  type        = string
}

variable "connection_preference" {
  description = "ACCEPT_AUTOMATIC or ACCEPT_MANUAL"
  type        = string
}

variable "consumer_accept_lists" {
  description = "(Optional) An array of projects/networks that are allowed to connect to this service attachment: The list needs to be either project-based or network-based."
  type = list(object({
    project_id_or_num = optional(string)
    network_url       = optional(string)
    connection_limit  = number
  }))
  default = []
}

variable "consumer_reject_lists" {
  description = "(Optional) An array of projects/networks that are not allowed to connect to this service attachment."
  type        = list(string)
  default     = null
}

variable "enable_proxy_protocol" {
  description = "(Optional) Enables the proxy protocol which is for supplying client TCP/IP address data in TCP connections that traverse proxies on their way to destination servers."
  type        = bool
  default     = false
}

variable "reconcile_connections" {
  description = "(Optional) Determines whether a consumer accept/reject list change can reconcile the statuses of existing ACCEPTED or REJECTED PSC endpoints."
  type        = bool
  default     = false
}

variable "propagated_connection_limit" {
  description = "(Optional) The number of consumer spokes that connected Private Service Connect endpoints can be propagated to through Network Connectivity Center."
  type        = number
  default     = null
}
