/**
 * Copyright 2024 Google LLC
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
  description = "The project ID to host the network in"
}

variable "vpn_region" {
  description = "The region where to deploy the VPN"
  default     = "europe-west4"
}

variable "instance_region" {
  description = "The region where to deploy the Router Instance in"
  default     = "us-central1"
}

variable "ncc_hub_name" {
  description = "The Name of the NCC Hub"
  type        = string
  default     = "ncc-hub"
}

variable "vpc_spoke_vpc_name" {
  description = "The VPC Name for the VPC Spoke"
  type        = string
  default     = "vpc-spoke"
}

variable "vpn_spoke_local_vpc_name" {
  description = "The name for the local VPC (GCP side) for the VPN Spoke"
  type        = string
  default     = "vpn-local-spoke"
}

variable "vpn_spoke_remote_vpc_name" {
  description = "The name for the remote VPC (fake on-orem) for the VPN Spoke"
  type        = string
  default     = "vpn-remote-spoke"
}

variable "router_appliance_vpc_name" {
  description = "The VPC Name for the VPC Spoke"
  type        = string
  default     = "router-appliance-spoke"
}
