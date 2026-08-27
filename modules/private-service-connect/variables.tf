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
  description = "Project ID for Private Service Connect."
  type        = string
}

variable "network_self_link" {
  description = "Network self link for Private Service Connect."
  type        = string
}

variable "dns_code" {
  description = "Code to identify DNS resources in the form of `{dns_code}-{dns_type}`"
  type        = string
  default     = "dz"
}

variable "private_service_connect_name" {
  description = "Private Service Connect endpoint name. Defaults to `global-psconnect-ip`"
  type        = string
  default     = "global-psconnect-ip"
}

variable "private_service_connect_ip" {
  description = "The internal IP to be used for the private service connect."
  type        = string
}

variable "forwarding_rule_name" {
  description = "Forwarding rule resource name. The forwarding rule name for PSC Google APIs must be an 1-20 characters string with lowercase letters and numbers and must start with a letter. Defaults to `globalrule`"
  type        = string
  default     = "globalrule"
}

variable "forwarding_rule_target" {
  description = "Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid."
  type        = string

  validation {
    condition     = var.forwarding_rule_target == "all-apis" || var.forwarding_rule_target == "vpc-sc"
    error_message = "For forwarding_rule_target only `all-apis` and `vpc-sc` are valid."
  }
}

variable "service_directory_namespace" {
  description = "Service Directory namespace to register the forwarding rule under."
  type        = string
  default     = null
}

variable "service_directory_region" {
  description = "Service Directory region to register this global forwarding rule under. Defaults to `us-central1` if not defined."
  type        = string
  default     = null
}

variable "psc_global_access" {
  description = "This is used in PSC consumer ForwardingRule to control whether the PSC endpoint can be accessed from another region. Defaults to `false`"
  type        = bool
  default     = false
}

variable "universe_domain" {
  description = "The universe domain to use for Google Cloud APIs. This defines the API endpoint boundary for your deployment. The default is 'googleapis.com' for the standard public Google Cloud. Modify this value if you are deploying to isolated environments like Google Distributed Cloud (GDC), Trusted Partner Cloud (TPC), or other sovereign cloud environments."
  type        = string
  default     = "googleapis.com"

  validation {
    condition     = var.universe_domain != null && length(trimspace(coalesce(var.universe_domain, ""))) > 0
    error_message = "The universe_domain variable cannot be null or an empty string."
  }
}

variable "pkg_dev_domain" {
  description = "Domain for Artifact Registry. Change if using a custom universe_domain."
  type        = string
  default     = "pkg.dev"

  validation {
    condition     = var.pkg_dev_domain != null && length(trimspace(coalesce(var.pkg_dev_domain, ""))) > 0
    error_message = "The pkg_dev_domain variable cannot be null or an empty string."
  }
}

variable "enable_gcr_dns" {
  description = "Enable DNS zone creation for legacy gcr.io. Set to false for GDC/TPC environments where Container Registry is not available."
  type        = bool
  default     = true
}
