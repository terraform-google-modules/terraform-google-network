/**
 * Copyright 2023 Google LLC
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
  attachment_targets = toset(flatten([formatlist("folders/%s", var.target_folders), local.org]))
  org                = var.target_org == null ? [] : [format("organizations/%s", var.target_org)]
}

# Create a firewall policy
resource "google_compute_firewall_policy" "fw_policy" {
  short_name  = var.policy_name
  parent      = var.parent_node
  description = var.description
}

# Associate the firewall policy with the target folders and organizations
resource "google_compute_firewall_policy_association" "target_associations" {
  for_each          = length(local.attachment_targets) > 0 ? local.attachment_targets : []
  name              = element(split("/", each.value), length(split("/", each.value)) - 1)
  attachment_target = each.value
  firewall_policy   = google_compute_firewall_policy.fw_policy.name
}

# Create firewall policy rules
resource "google_compute_firewall_policy_rule" "rules" {
  provider = google-beta

  for_each                = { for x in var.rules : x.priority => x }
  priority                = each.key
  action                  = each.value.action
  description             = each.value.description
  direction               = each.value.direction
  disabled                = each.value.disabled
  enable_logging          = each.value.enable_logging
  firewall_policy         = google_compute_firewall_policy.fw_policy.name
  target_service_accounts = each.value.target_service_accounts
  target_resources        = formatlist("https://www.googleapis.com/compute/v1/%s", each.value.target_resources)

  match {
    src_ip_ranges             = lookup(each.value.match, "src_ip_ranges", [])
    src_fqdns                 = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_fqdns", []) : []
    src_region_codes          = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_region_codes", []) : []
    src_threat_intelligences  = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_threat_intelligences", []) : []
    src_address_groups        = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_address_groups", []) : []
    dest_ip_ranges            = lookup(each.value.match, "dest_ip_ranges", [])
    dest_fqdns                = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_fqdns", []) : []
    dest_region_codes         = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_region_codes", []) : []
    dest_threat_intelligences = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_threat_intelligences", []) : []
    dest_address_groups       = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_address_groups", []) : []

    dynamic "layer4_configs" {
      for_each = each.value.match.layer4_configs
      content {
        ip_protocol = layer4_configs.value.ip_protocol
        ports       = layer4_configs.value.ports
      }
    }

  }

}
