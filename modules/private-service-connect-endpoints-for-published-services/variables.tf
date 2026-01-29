/**
 * Copyright 2022 Google LLC
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
  description = "Project ID in which to provision the resources."
  type        = string
}

variable "region" {
  description = "Region in which to provision the resources."
  type        = string
}

variable "network" {
  description = "Name, id or self link of the network to create resources in. For Shared VPC case, use network self link."
  type        = string
}

variable "subnetwork" {
  description = "Name, id or self link of the subnetwork to create resources in. For Shared VPC case, use subnetwork self link."
  type        = string
}

variable "forwarding_rule_name" {
  description = "Private Service Connect Forwarding Rule resource name. Follow regular GCE naming pattern: https://docs.cloud.google.com/compute/docs/naming-resources#resource-name-format."
  type        = string
  default     = "psc-for-published-services-endpoint"
}

variable "address_name" {
  description = "Private Service Connect Endpoint address name."
  type        = string
  default     = "psc-for-published-services-endpoint-address"
}

variable "ip_address" {
  description = "Private Service Connect Endpoint IP address. GCP will pick an IP if left unset."
  type        = string
  default     = null
}

variable "ip_version" {
  description = "`IPv4`or `IPv6`. Only set this field when private_service_connect_ip is unset. If both ip_address and ip_version are unset, GCP will pick an IPv4 address."
  type        = string
  default     = null
}

variable "service_attachment" {
  description = "The target service attachment resource URL for this Private Service Connect Endpoint."
  type        = string
}

variable "service_directory_namespace" {
  description = "Service Directory namespace to register the forwarding rule under."
  type        = string
  default     = null
}

variable "psc_global_access" {
  description = "Whether to allow Private Service Connect global access."
  type        = bool
  default     = false
}
