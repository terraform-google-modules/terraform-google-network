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
      name        = "deny-ingress-6534-6566"
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
      name        = "deny-egress-6534-6566"
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
      name        = "allow-backend-to-databases"
      description = "Allow backend nodes connection to databases instances"
      direction   = "INGRESS"
      target_tags = ["databases"] # target_tags
      source_tags = ["backed"]    # source_tags
      allow = [{
        protocol = "tcp"
        ports    = ["3306", "5432", "1521", "1433"]
      }]

    },

    // Example how to allow connection from an instance with a given service account
    {
      name                    = "allow-all-admin-sa"
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

    // Example how to allow connection from an source range to destination ranges
    {
      name               = "allow-ssh-ingress"
      description        = "Allow all traffic from 10.0.0.0/24 to 10.1.0.0/24"
      direction          = "INGRESS"
      ranges             = null
      destination_ranges = ["10.0.0.0/24"]
      source_ranges      = ["10.1.0.0/24"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    },
    {
      name               = "deny-ssh-egress"
      description        = "Deny all traffic from 10.4.0.0/24 to 10.3.0.0/24"
      direction          = "EGRESS"
      ranges             = null
      destination_ranges = ["10.3.0.0/24"]
      source_ranges      = ["10.4.0.0/24"]
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

// Custom firewall rules
# locals {
#   custom_rules = [
#     // Example of custom tcp/udp rule
#     {
#       name                    = "deny-ingress-6534-6566"
#       description             = "Deny all INGRESS to port 6534-6566"
#       direction               = "INGRESS"
#       ranges                  = ["0.0.0.0/0"]
#       source_service_accounts = false # if `true` targets/sources expect list of instances SA, if false - list of tags
#       deny = [{
#         protocol = "tcp"
#         ports    = ["6534-6566"]
#         },
#         {
#           protocol = "udp"
#           ports    = ["6534-6566"]
#       }]

#     },

#     // Example how to allow connection from instances with `backend` tag, to instances with `databases` tag
#     {
#       name        = "allow-backend-to-databases"
#       description = "Allow backend nodes connection to databases instances"
#       direction   = "INGRESS"
#       target_tags = ["databases"] # target_tags
#       source_tags = ["backed"]    # source_tags
#       allow = [{
#         protocol = "tcp"
#         ports    = ["3306", "5432", "1521", "1433"]
#       }]

#     },

#     // Example how to allow connection from an instance with a given service account
#     {
#       name                    = "allow-all-admin-sa"
#       description             = "Allow all traffic from admin sa instances"
#       direction               = "INGRESS"
#       source_service_accounts = ["admin@my-shiny-org.iam.gserviceaccount.com"]
#       allow = [{
#         protocol = "tcp"
#         ports    = null # all ports
#         },
#         {
#           protocol = "udp"
#           ports    = null # all ports
#         }
#       ]
#     },

#     // Example how to allow connection from an source range to destination ranges
#     {
#       name               = "allow-all-admin-sa"
#       description        = "Allow all traffic from admin sa instances"
#       direction          = "INGRESS"
#       destination_ranges = ["10.0.0.0/24"]
#       source_ranges      = ["10.1.0.0/24"]
#       allow = [{
#         protocol = "tcp"
#         ports    = null # all ports
#         },
#         {
#           protocol = "udp"
#           ports    = null # all ports
#         }
#       ]
#     },


#   ]

# }



module "test-firewall-submodule" {
  source       = "../../modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.test-vpc-module.network_name
  # internal_ranges_enabled = true
  # internal_ranges         = module.test-vpc-module.subnets_ips

  # internal_allow = [
  #   {
  #     protocol = "icmp"
  #   },
  #   {
  #     protocol = "tcp",
  #     ports    = ["8080", "1000-2000"]
  #   },
  #   {
  #     protocol = "udp"
  #     # all ports will be opened if `ports` key isn't specified
  #   },
  # ]
  rules = local.custom_rules
}
