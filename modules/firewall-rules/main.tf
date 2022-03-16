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

locals {
  rules = {
    for r in var.rules : r.name => r
  }
}

resource "google_compute_firewall" "rules" {
  for_each                = local.rules
  name                    = each.value.name
  description             = lookup(each.value, "description", null)
  direction               = each.value.direction
  network                 = var.network_name
  project                 = var.project_id
  source_ranges           = each.value.direction == "INGRESS" ? lookup(each.value, "ranges", null) : null
  destination_ranges      = each.value.direction == "EGRESS" ? lookup(each.value, "ranges", null) : null
  source_tags             = lookup(each.value, "source_tags", null)
  source_service_accounts = lookup(each.value, "source_service_accounts", null)
  target_tags             = lookup(each.value, "target_tags", null)
  target_service_accounts = lookup(each.value, "target_service_accounts", null)
  priority                = lookup(each.value, "priority", null)
  disabled                = lookup(each.value, "disabled", false)

  dynamic "log_config" {
    for_each = lookup(each.value, "log_config") == null ? [] : [each.value.log_config]
    content {
      metadata = log_config.value.metadata
    }
  }

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}
