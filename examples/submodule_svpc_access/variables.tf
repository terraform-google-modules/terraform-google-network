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

variable "host_project_id" {
  description = "Id of the host project where the shared VPC will be created."
}

variable "service_project_id_full_access" {
  description = "Id of the service project that will get VPC-level access."
}

variable "service_project_number_first_subnet" {
  description = "Project number to derive service accounts with access to first subnet."
}

variable "service_project_number_multi_subnet" {
  description = "Project number to derive service accounts with access to first and second subnet."
}

variable "network_name" {
  description = "Name of the shared VPC."
  default     = "test-svpc"
}
