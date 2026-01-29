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
  description = "The project ID where the Service Connection Policy will be created."
  type        = string
}

variable "name" {
  description = "Name of the Service Connection Policy."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "location" {
  description = "Region where the policy will be created (e.g., us-central1)."
  type        = string

  validation {
    condition     = can(regex("^[a-z]+-[a-z0-9]+[0-9]$", var.location))
    error_message = "location must look like a region (e.g., us-central1, europe-west1)."
  }
}

variable "network" {
  description = "VPC network self_link (recommended) or id to attach the policy to."
  type        = string

  validation {
    condition     = length(trimspace(var.network)) > 0
    error_message = "network must not be empty."
  }
}

variable "service_class" {
  description = "Service class of the managed service to enable PSC for (see product docs for valid values)."
  type        = string

  validation {
    condition     = length(trimspace(var.service_class)) > 0
    error_message = "service_class must not be empty."
  }
}

variable "description" {
  description = "Optional description for the policy."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the policy."
  type        = map(string)
  default     = {}
}

variable "subnetworks" {
  description = "List of subnetwork self_links used by PSC (psc_config.subnetworks)."
  type        = list(string)
  default     = []

    validation {
    condition = alltrue([
        for s in var.subnetworks : length(trimspace(s)) > 0
    ])
    error_message = "subnetworks must not contain empty strings."
    }
}

variable "limit" {
  description = "Optional PSC connection limit (psc_config.limit)."
  type        = number
  default     = null

  validation {
    condition     = var.limit == null || var.limit > 0
    error_message = "limit must be null or a positive number."
  }
}
