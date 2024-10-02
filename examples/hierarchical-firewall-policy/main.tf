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
  prefix = "hierarchical"
}

resource "random_string" "random_suffix" {
  length  = 6
  special = false
  lower   = true
  upper   = false
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "${local.prefix}-fw-test-svc-acct"
  display_name = "${local.prefix} firewall policy test service account"
}

resource "google_compute_network" "network" {
  project = var.project_id
  name    = "${local.prefix}-network"
}

resource "google_compute_network" "network_backup" {
  project = var.project_id
  name    = "${local.prefix}-network-backup"
}

module "firewal_policy" {
  source  = "terraform-google-modules/network/google//modules/hierarchical-firewall-policy"
  version = "~> 9.0"

  parent_node    = "folders/${var.folder1}"
  policy_name    = "${local.prefix}-firewall-policy-${random_string.random_suffix.result}"
  description    = "test ${local.prefix} firewall policy"
  target_folders = [var.folder2, var.folder3]

  rules = [
    {
      priority       = "1"
      direction      = "INGRESS"
      action         = "allow"
      rule_name      = "ingress-1"
      description    = "test ingres rule 1"
      enable_logging = true
      match = {
        src_ip_ranges            = ["10.100.0.1/32"]
        src_fqdns                = ["example.com"]
        src_region_codes         = ["US"]
        src_threat_intelligences = ["iplist-public-clouds"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority    = "2"
      direction   = "INGRESS"
      action      = "deny"
      rule_name   = "ingress-2"
      disabled    = true
      description = "test ingres rule 2"
      target_resources = [
        "projects/${var.project_id}/global/networks/${local.prefix}-network-backup",
      ]
      match = {
        src_ip_ranges    = ["10.100.0.2/32"]
        src_fqdns        = ["example.org"]
        src_region_codes = ["BE"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority                = "3"
      direction               = "INGRESS"
      action                  = "allow"
      rule_name               = "ingress-3"
      disabled                = true
      description             = "test ingres rule 3"
      enable_logging          = true
      target_service_accounts = ["fw-test-svc-acct@${var.project_id}.iam.gserviceaccount.com"]
      match = {
        src_ip_ranges  = ["10.100.0.3/32"]
        dest_ip_ranges = ["10.100.0.103/32"]
        layer4_configs = [
          {
            ip_protocol = "tcp"
            ports       = ["80"]
          },
        ]
      }
    },
    {
      priority       = "101"
      direction      = "EGRESS"
      action         = "allow"
      rule_name      = "egress-101"
      description    = "test egress rule 101"
      enable_logging = true
      match = {
        src_ip_ranges             = ["10.100.0.2/32"]
        dest_fqdns                = ["example.com"]
        dest_region_codes         = ["US"]
        dest_threat_intelligences = ["iplist-public-clouds"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority    = "102"
      direction   = "EGRESS"
      action      = "deny"
      rule_name   = "egress-102"
      disabled    = true
      description = "test egress rule 102"
      target_resources = [
        "projects/${var.project_id}/global/networks/${local.prefix}-network",
      ]
      match = {
        src_ip_ranges     = ["10.100.0.102/32"]
        dest_ip_ranges    = ["10.100.0.2/32"]
        dest_region_codes = ["AR"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority                = "103"
      direction               = "EGRESS"
      action                  = "allow"
      rule_name               = "egress-103"
      disabled                = true
      description             = "test ingres rule 103"
      enable_logging          = true
      target_service_accounts = ["fw-test-svc-acct@${var.project_id}.iam.gserviceaccount.com"]
      match = {
        dest_ip_ranges = ["10.100.0.103/32"]
        layer4_configs = [
          {
            ip_protocol = "tcp"
            ports       = ["80", "8080", "8081-8085"]
          },
        ]
      }
    },

  ]
  depends_on = [
    google_compute_network.network,
    google_compute_network.network_backup,
  ]

}

module "firewal_policy_no_rule" {
  source  = "terraform-google-modules/network/google//modules/hierarchical-firewall-policy"
  version = "~> 9.0"

  parent_node = "folders/${var.folder1}"
  policy_name = "${local.prefix}-firewall-policy-no-rules-${random_string.random_suffix.result}"
  description = "${local.prefix} test firewall policy without any rules"
}
