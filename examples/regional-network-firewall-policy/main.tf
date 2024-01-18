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
  prefix   = "regional"
  location = "us-central1"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "random_string" "random_suffix" {
  length  = 6
  special = false
  lower   = true
  upper   = false
}

resource "google_compute_network" "network" {
  project = var.project_id

  name = "${local.prefix}-network"
}

resource "google_compute_network" "network_backup" {
  project = var.project_id
  name    = "${local.prefix}-network-backup"
}

resource "google_tags_tag_key" "tag_key" {

  description = "For keyname resources."
  parent      = "projects/${data.google_project.project.number}"
  purpose     = "GCE_FIREWALL"
  short_name  = local.prefix
  purpose_data = {
    network = "${var.project_id}/${google_compute_network.network.name}"
  }
}

resource "google_tags_tag_value" "tag_value" {

  description = "For valuename resources."
  parent      = "tagKeys/${google_tags_tag_key.tag_key.name}"
  short_name  = "yes"
}

resource "google_network_security_address_group" "networksecurity_address_group" {
  provider = google-beta

  name        = "${local.prefix}-policy"
  parent      = "projects/${var.project_id}"
  description = "${local.prefix} networksecurity_address_group"
  location    = local.location
  items       = ["208.80.154.224/32"]
  type        = "IPV4"
  capacity    = 100
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "${local.prefix}-fw-test-svc-acct"
  display_name = "${local.prefix} firewall policy test service account"
}

module "firewal_policy" {
  source  = "terraform-google-modules/network/google//modules/network-firewall-policy"
  version = "~> 9.0"

  project_id  = var.project_id
  policy_name = "${local.prefix}-firewall-policy-${random_string.random_suffix.result}"
  description = "test ${local.prefix} firewall policy"
  target_vpcs = [
    "projects/${var.project_id}/global/networks/${local.prefix}-network",
    "projects/${var.project_id}/global/networks/${local.prefix}-network-backup",
  ]

  policy_region = local.location

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
        src_fqdns                = ["google.com"]
        src_region_codes         = ["US"]
        src_threat_intelligences = ["iplist-public-clouds"]
        src_secure_tags          = ["tagValues/${google_tags_tag_value.tag_value.name}"]
        src_address_groups       = [google_network_security_address_group.networksecurity_address_group.id]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority           = "2"
      direction          = "INGRESS"
      action             = "deny"
      rule_name          = "ingress-2"
      disabled           = true
      description        = "test ingres rule 2"
      target_secure_tags = ["tagValues/${google_tags_tag_value.tag_value.name}"]
      match = {
        src_ip_ranges    = ["10.100.0.2/32"]
        src_fqdns        = ["google.org"]
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
        dest_fqdns                = ["google.com"]
        dest_region_codes         = ["US"]
        dest_threat_intelligences = ["iplist-public-clouds"]
        dest_address_groups       = [google_network_security_address_group.networksecurity_address_group.id]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority           = "102"
      direction          = "EGRESS"
      action             = "deny"
      rule_name          = "egress-102"
      disabled           = true
      description        = "test egress rule 102"
      target_secure_tags = ["tagValues/${google_tags_tag_value.tag_value.name}"]
      match = {
        dest_ip_ranges    = ["10.100.0.102/32"]
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
  ]
}

module "firewal_policy_no_rule" {
  source        = "terraform-google-modules/network/google//modules/network-firewall-policy"
  version       = "~> 9.0"
  project_id    = var.project_id
  policy_name   = "${local.prefix}-firewall-policy-no-rules-${random_string.random_suffix.result}"
  description   = "${local.prefix} test firewall policy without any rules"
  policy_region = local.location
}
