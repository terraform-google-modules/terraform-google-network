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

variable "subnets" {
  type        = "list"
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = "map"
  description = "Secondary ranges that will be used in some of the subnets"
}

variable "shared_vpc_host" {
  type        = "string"
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = "false"
}
