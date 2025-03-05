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

variable "project_id" {
  type        = string
  description = "Project in which the vpc connector will be deployed."
}

variable "vpc_connectors" {
  type = list(object({
    name            = string,
    region          = string,
    network         = optional(string, null),
    subnet_name     = optional(string, null),
    ip_cidr_range   = optional(string, null),
    host_project_id = optional(string, null),
    machine_type    = optional(string, null),
    min_instances   = optional(number, null),
    max_instances   = optional(number, null),
    max_throughput  = optional(number, null)
  }))
  default     = []
  description = "List of VPC serverless connectors."
}
