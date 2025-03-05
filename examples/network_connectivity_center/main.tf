/**
 * Copyright 2024 Google LLC
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

module "network_connectivity_center" {
  source       = "terraform-google-modules/network/google//modules/network-connectivity-center"
  project_id   = var.project_id
  ncc_hub_name = var.ncc_hub_name
  ncc_hub_labels = {
    "module" = "ncc"
  }
  spoke_labels = {
    "created-by" = "terraform-google-ncc-example"
  }
  vpc_spokes = {
    "vpc-1" = {
      uri = module.vpc_spoke_vpc.network_id
      labels = {
        "spoke-type" = "vpc"
      }
    }
  }
  hybrid_spokes = {
    "vpn-1" = {
      type                       = "vpn"
      uris                       = [for k, v in module.local_to_remote_vpn.tunnel_self_links : v]
      site_to_site_data_transfer = true
      location                   = var.vpn_region
    }
  }
  router_appliance_spokes = {
    "appliance-1" = {
      instances = [
        {
          virtual_machine = google_compute_instance.router_appliance_1.id
          ip_address      = google_compute_instance.router_appliance_1.network_interface[0].network_ip
        },

      ]
      location                   = var.instance_region
      site_to_site_data_transfer = false
    }
  }
}

################################
#          VPC Spoke           #
################################
module "vpc_spoke_vpc" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = var.vpc_spoke_vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "vpc-spoke-subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name   = "vpc-spoke-subnet-02"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "us-east1"
    },
    {
      subnet_name   = "vpc-spoke-subnet-03"
      subnet_ip     = "10.10.30.0/24"
      subnet_region = "europe-west4"
    }
  ]
}

################################
#          VPN Spoke           #
################################
# Simulates an on-prem network that will be connected over VPN
module "vpn_spoke_remote_vpc" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = var.vpn_spoke_remote_vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "vpn-subnet-01"
      subnet_ip     = "10.20.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name   = "vpn-subnet-02"
      subnet_ip     = "10.20.20.0/24"
      subnet_region = "us-east1"
    },
    {
      subnet_name   = "vpn-subnet-03"
      subnet_ip     = "10.20.30.0/24"
      subnet_region = "europe-west4"
    }
  ]
}

module "vpn_spoke_local_vpc" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = var.vpn_spoke_local_vpc_name
  routing_mode = "GLOBAL"
  subnets      = []
}

module "remote_to_local_vpn" {
  source  = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version = "~> 4.0"

  project_id       = var.project_id
  region           = var.vpn_region
  network          = module.vpn_spoke_remote_vpc.network_id
  name             = "remote-to-local"
  router_asn       = 64513
  peer_gcp_gateway = module.local_to_remote_vpn.self_link
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = module.local_to_remote_vpn.random_secret
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.2"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.1/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = module.local_to_remote_vpn.random_secret
    }
  }
}

module "local_to_remote_vpn" {
  source  = "terraform-google-modules/vpn/google//modules/vpn_ha"
  version = "~> 4.0"

  project_id       = var.project_id
  region           = var.vpn_region
  network          = module.vpn_spoke_local_vpc.network_id
  name             = "local-to-remote"
  peer_gcp_gateway = module.remote_to_local_vpn.self_link
  router_asn       = 64514
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64513
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = null
      shared_secret                   = ""
    }
  }
}


################################
#    Router Appliance Spoke    #
################################
data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.instance_region
}

resource "random_shuffle" "zone" {
  input        = data.google_compute_zones.available.names
  result_count = 1
}

module "router_appliance_spoke_vpc" {
  source       = "terraform-google-modules/network/google"
  project_id   = var.project_id
  network_name = var.router_appliance_vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "router-appliance-subnet-01"
      subnet_ip     = "10.20.10.0/24"
      subnet_region = var.instance_region
    }
  ]
}

resource "google_compute_instance" "router_appliance_1" {
  name           = "fake-router-appliance-1"
  machine_type   = "e2-medium"
  project        = var.project_id
  can_ip_forward = true
  zone           = random_shuffle.zone.result[0]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = module.router_appliance_spoke_vpc.subnets["${var.instance_region}/router-appliance-subnet-01"].id
    access_config {
      network_tier = "PREMIUM"
    }
  }
}
