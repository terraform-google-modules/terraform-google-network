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

# Pending new google-cloud-beta provider release Estimated Release 03/22
# https://github.com/hashicorp/terraform-provider-google/issues/8475
resource "google_vpc_access_connector" "connector_beta" {
  for_each      = { for connector in var.vpc_connectors : connector.name => connector }
  provider      = google-beta
  name          = each.value.name
  project       = var.project_id
  region        = each.value.region
  ip_cidr_range = lookup(each.value, "ip_cidr_range", null)
  network       = lookup(each.value, "network", null)
  dynamic "subnet" {
    for_each = each.value.subnet_name == null ? [] : [each.value]
    content {
      name       = each.value.subnet_name
      project_id = lookup(each.value, "host_project_id", null)
    }
  }
  machine_type   = lookup(each.value, "machine_type", null)
  min_instances  = lookup(each.value, "min_instances", null)
  max_instances  = lookup(each.value, "max_instances", null)
  max_throughput = lookup(each.value, "max_throughput", null)
}
