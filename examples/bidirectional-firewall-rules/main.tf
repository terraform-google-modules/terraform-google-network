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
  subnet_01 = "${var.network_name}-subnet-01"
  subnet_02 = "${var.network_name}-subnet-02"

  custom_rules = [
    // Example of custom tcp/udp rule
    {
      name        = "fwtest-deny-ingress-6534-6566"
      description = "Deny all INGRESS to port 6534-6566"
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
      deny = [{
        protocol = "tcp"
        ports    = ["6534-6566"]
        },
        {
          protocol = "udp"
          ports    = ["6534-6566"]
      }]

    },

    {
      name        = "fwtest-deny-egress-6534-6566"
      description = "Deny all EGRESS to 47.189.12.139/32 port 6534-6566"
      direction   = "EGRESS"
      ranges      = ["47.189.12.139/32"]
      deny = [{
        protocol = "tcp"
        ports    = ["6534-6566"]
        },
        {
          protocol = "udp"
          ports    = ["6534-6566"]
      }]

    },

    // Example how to allow connection from instances with `backend` tag, to instances with `databases` tag
    {
      name        = "fwtest-allow-backend-to-databases"
      description = "Allow backend nodes connection to databases instances"
      direction   = "INGRESS"
      target_tags = ["databases"]
      source_tags = ["backed"]
      allow = [{
        protocol = "tcp"
        ports    = ["3306", "5432", "1521", "1433"]
      }]

    },

    // Example how to allow connection from an instance with a given service account
    {
      name                    = "fwtest-allow-all-admin-sa"
      description             = "Allow all traffic from admin sa instances"
      direction               = "INGRESS"
      source_service_accounts = ["admin@my-shiny-org.iam.gserviceaccount.com"]
      allow = [{
        protocol = "tcp"
        ports    = null # all ports
        },
        {
          protocol = "udp"
          ports    = null # all ports
        }
      ]
    },

  ]


  custom_rules_ingress = [
    // Example of custom tcp/udp rule
    {
      name          = "fwtest-deny-ingress-6500-6566"
      description   = "Deny all INGRESS to port 6500-6566"
      source_ranges = ["0.0.0.0/0"]
      deny = [{
        protocol = "tcp"
        ports    = ["6500-6566"]
        },
        {
          protocol = "udp"
          ports    = ["6500-6566"]
      }]

    },
    {
      name        = "fwtest-allow-backend-to-db"
      description = "Allow backend nodes connection to databases instances"
      target_tags = ["db"]     # target_tags
      source_tags = ["backed"] # source_tags
      allow = [{
        protocol = "tcp"
        ports    = ["3306", "5432", "1521", "1433"]
      }]

    },
    {
      name                    = "fwtest-allow-admin-svc-acct"
      description             = "Allow all traffic from admin sa instances"
      source_service_accounts = ["admin@my-shiny-org.iam.gserviceaccount.com"]
      allow = [{
        protocol = "tcp"
        ports    = null # all ports
        },
        {
          protocol = "udp"
          ports    = null # all ports
        }
      ]
    },
    {
      name               = "fwtest-allow-ssh-ing"
      description        = "Allow all traffic from 10.2.0.0/24 to 10.3.0.0/24"
      ranges             = null
      destination_ranges = ["10.2.0.0/24"]
      source_ranges      = ["10.3.0.0/24"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    },

  ]


  custom_rules_egress = [
    {
      name               = "fwtest-deny-egress-6400-6466"
      description        = "Deny all EGRESS to 47.190.12.139/32 port 6400-6466"
      destination_ranges = ["47.190.12.139/32"]
      deny = [{
        protocol = "tcp"
        ports    = ["6400-6466"]
        },
        {
          protocol = "udp"
          ports    = ["6400-6466"]
      }]

    },

    {
      name               = "fwtest-deny-ssh-egr"
      description        = "Deny all traffic to 10.10.0.0/24 to 10.11.0.0/24"
      destination_ranges = ["10.10.0.0/24"]
      source_ranges      = ["10.11.0.0/24"]
      deny = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    },


  ]


}

module "test-vpc-module" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = local.subnet_01
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]
}


module "test-firewall-submodule" {
  source       = "../../modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.test-vpc-module.network_name
  rules        = local.custom_rules
}

module "test-firewall-submodule-ing-egr" {
  source        = "../../modules/firewall-rules"
  project_id    = var.project_id
  network_name  = module.test-vpc-module.network_name
  ingress_rules = local.custom_rules_ingress
  egress_rules  = local.custom_rules_egress
}
