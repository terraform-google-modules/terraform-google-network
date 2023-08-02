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
  prefix = var.policy_region == null ? var.policy_name : "${var.policy_name}-${var.policy_region}"
  global = var.policy_region == null
}

########## Global ##########

resource "google_compute_network_firewall_policy" "fw_policy" {
  count       = local.global ? 1 : 0
  name        = var.policy_name
  project     = var.project_id
  description = var.description
}

resource "google_compute_network_firewall_policy_association" "vpc_associations" {
  for_each          = local.global && length(var.target_vpcs) > 0 ? { for x in var.target_vpcs : base64encode(x) => x } : {}
  name              = "${local.prefix}-${element(split("/", each.value), length(split("/", each.value)) - 1)}"
  attachment_target = each.value
  firewall_policy   = google_compute_network_firewall_policy.fw_policy[0].name
  project           = var.project_id
}

resource "google_compute_network_firewall_policy_rule" "rules" {
  provider = google-beta

  for_each                = local.global ? { for x in var.rules : x.priority => x } : {}
  priority                = each.key
  project                 = var.project_id
  action                  = each.value.action
  description             = each.value.description
  direction               = each.value.direction
  disabled                = each.value.disabled
  enable_logging          = each.value.enable_logging
  firewall_policy         = google_compute_network_firewall_policy.fw_policy[0].name
  rule_name               = each.value.rule_name
  target_service_accounts = each.value.target_service_accounts

  ## targetSecureTag may not be set at the same time as targetServiceAccounts
  dynamic "target_secure_tags" {
    for_each = each.value.target_service_accounts != null || each.value.target_secure_tags == null ? [] : toset(each.value.target_secure_tags)
    content {
      name = target_secure_tags.value
    }
  }

  match {
    src_ip_ranges             = lookup(each.value.match, "src_ip_ranges", [])
    src_fqdns                 = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_fqdns", []) : []
    src_region_codes          = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_region_codes", []) : []
    src_threat_intelligences  = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_threat_intelligences", []) : []
    src_address_groups        = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_address_groups", []) : []
    dest_ip_ranges            = lookup(each.value.match, "dest_ip_ranges", []) # == null ? [] : lookup(each.value.match, "dest_ip_ranges", [])
    dest_fqdns                = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_fqdns", []) : []
    dest_region_codes         = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_region_codes", []) : []
    dest_threat_intelligences = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_threat_intelligences", []) : []
    dest_address_groups       = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_address_groups", []) : []

    dynamic "src_secure_tags" {
      for_each = each.value.direction != "INGRESS" || each.value.match.src_secure_tags == null ? [] : toset(each.value.match.src_secure_tags)
      content {
        name = src_secure_tags.value
      }
    }

    dynamic "layer4_configs" {
      for_each = each.value.match.layer4_configs
      content {
        ip_protocol = layer4_configs.value.ip_protocol
        ports       = layer4_configs.value.ports
      }
    }

  }

}


########## Regional ##########

resource "google_compute_region_network_firewall_policy" "fw_policy" {
  count       = local.global ? 0 : 1
  name        = var.policy_name
  project     = var.project_id
  description = var.description
  region      = var.policy_region
}

resource "google_compute_region_network_firewall_policy_association" "vpc_associations" {
  for_each          = !local.global && length(var.target_vpcs) > 0 ? { for x in var.target_vpcs : base64encode(x) => x } : {}
  name              = "${local.prefix}-${element(split("/", each.value), length(split("/", each.value)) - 1)}"
  attachment_target = each.value
  firewall_policy   = google_compute_region_network_firewall_policy.fw_policy[0].name
  project           = var.project_id
  region            = var.policy_region
}

resource "google_compute_region_network_firewall_policy_rule" "rules" {
  provider = google-beta

  for_each                = local.global ? {} : { for x in var.rules : x.priority => x }
  region                  = var.policy_region
  priority                = each.key
  project                 = var.project_id
  action                  = each.value.action
  description             = each.value.description
  direction               = each.value.direction
  disabled                = each.value.disabled
  enable_logging          = each.value.enable_logging
  firewall_policy         = google_compute_region_network_firewall_policy.fw_policy[0].name
  rule_name               = each.value.rule_name
  target_service_accounts = each.value.target_service_accounts

  ## targetSecureTag may not be set at the same time as targetServiceAccounts
  dynamic "target_secure_tags" {
    for_each = each.value.target_service_accounts != null || each.value.target_secure_tags == null ? [] : toset(each.value.target_secure_tags)
    content {
      name = target_secure_tags.value
    }
  }

  match {
    src_ip_ranges             = each.value.match.src_ip_ranges
    src_fqdns                 = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_fqdns", []) : []
    src_region_codes          = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_region_codes", []) : []
    src_threat_intelligences  = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_threat_intelligences", []) : []
    src_address_groups        = each.value.direction == "INGRESS" ? lookup(each.value.match, "src_address_groups", []) : []
    dest_ip_ranges            = each.value.match.dest_ip_ranges
    dest_fqdns                = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_fqdns", []) : []
    dest_region_codes         = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_region_codes", []) : []
    dest_threat_intelligences = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_threat_intelligences", []) : []
    dest_address_groups       = each.value.direction == "EGRESS" ? lookup(each.value.match, "dest_address_groups", []) : []

    dynamic "src_secure_tags" {
      for_each = each.value.direction != "INGRESS" || each.value.match.src_secure_tags == null ? [] : toset(each.value.match.src_secure_tags)
      content {
        name = src_secure_tags.value
      }
    }

    dynamic "layer4_configs" {
      for_each = each.value.match.layer4_configs
      content {
        ip_protocol = layer4_configs.value.ip_protocol
        ports       = layer4_configs.value.ports
      }
    }

  }

}
