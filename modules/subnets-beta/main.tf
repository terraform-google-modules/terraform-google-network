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

/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  provider                 = google-beta
  count                    = length(var.subnets)
  name                     = var.subnets[count.index].subnet_name
  ip_cidr_range            = var.subnets[count.index].subnet_ip
  region                   = var.subnets[count.index].subnet_region
  private_ip_google_access = lookup(var.subnets[count.index], "subnet_private_access", "false")
  dynamic "log_config" {
    for_each = lookup(var.subnets[count.index], "subnet_flow_logs", false) ? [{
      aggregation_interval = lookup(var.subnets[count.index], "subnet_flow_logs_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(var.subnets[count.index], "subnet_flow_logs_sampling", "0.5")
      metadata             = lookup(var.subnets[count.index], "subnet_flow_logs_metadata", "INCLUDE_ALL_METADATA")
      filter_expr          = lookup(var.subnets[count.index], "subnet_flow_logs_filter", "true")
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
    }
  }
  network     = var.network_name
  project     = var.project_id
  description = lookup(var.subnets[count.index], "description", null)
  secondary_ip_range = [
    for i in range(
      length(
        contains(
        keys(var.secondary_ranges), var.subnets[count.index].subnet_name) == true
        ? var.secondary_ranges[var.subnets[count.index].subnet_name]
        : []
    )) :
    var.secondary_ranges[var.subnets[count.index].subnet_name][i]
  ]

  purpose = lookup(var.subnets[count.index], "purpose", null)
  role    = lookup(var.subnets[count.index], "role", null)

  depends_on = [var.module_depends_on]
}
