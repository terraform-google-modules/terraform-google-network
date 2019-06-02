/**
 * Copyright 2018 Google LLC
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
  description = "The ID of the project where this VPC will be created"
}

variable "network_name" {
  description = "The name of the network being created"
}

variable "routing_mode" {
  type        = "string"
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "shared_vpc_host" {
  type        = "string"
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = "false"
}

variable "subnets" {
  type        = "list"
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = "map"
  description = "Secondary ranges that will be used in some of the subnets"
}

variable "routes" {
  type        = "list"
  description = "List of routes being created in this VPC"
  default     = []
}

variable "delete_default_internet_gateway_routes" {
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = "false"
}

# allow controlling shared VPC project attachment or subnet access
# passed-in values can be dynamic, so variables used in count need to be separate

variable "shared_vpc_service_projects_num" {
  description = "Number of service projects that will get full access to the shared VPC."
  default     = 0
}

variable "shared_vpc_service_projects" {
  description = "Service projects that will get full access to the shared VPC."
  default     = []
}

variable "shared_vpc_iam_subnets" {
  description = "Names of subnets on which to grant network user roles."
  default     = []
}

variable "shared_vpc_iam_members" {
  description = "Comma-delimited members that will be granted network user roles, one per subnet."
  default     = []
}
