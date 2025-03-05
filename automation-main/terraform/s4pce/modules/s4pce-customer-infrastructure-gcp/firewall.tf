/*
  Description: Handles firewall rule creation
  Layer: 00
  Dependencies: none
  Comments: N/A
*/

locals {
  backend_subnets = flatten([
    for key, value in var.subnets : [
      for subkey, subvalue in value : subvalue
    ]
  ])
}

##### Access-VPC
module "context_gcp_firewall_customer_vpc" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.module_context.context
  name        = "vpc"
  description = "Allow all traffic from backend subnets"
}
resource "google_compute_firewall" "customer_vpc" {
  name        = module.context_gcp_firewall_customer_vpc.name
  description = module.context_gcp_firewall_customer_vpc.description
  network     = google_compute_network.customer.name

  allow {
    protocol = "all"
  }

  source_ranges = local.backend_subnets
  target_tags   = [module.context_gcp_firewall_customer_vpc.name]
}

##### All-Egress
module "context_gcp_firewall_customer_all_egress" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.module_context.context
  name        = "all-egress"
  description = "Allow all egress traffic"
}
resource "google_compute_firewall" "customer_all_egress" {
  name        = module.context_gcp_firewall_customer_all_egress.name
  description = module.context_gcp_firewall_customer_all_egress.description
  network     = google_compute_network.customer.name
  direction   = "EGRESS"
  allow {
    protocol = "all"
  }
}

##### Access-Management
module "context_gcp_firewall_customer_access_management" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.module_context.context
  name        = "management-vpc"
  description = "Allow all traffic from workload management"
}
resource "google_compute_firewall" "access_management" {
  name        = module.context_gcp_firewall_customer_access_management.name
  description = module.context_gcp_firewall_customer_access_management.description
  network     = google_compute_network.customer.name

  allow {
    protocol = "all"
  }

  source_ranges = [var.gcn_management.cidr]
  target_tags   = [module.context_gcp_firewall_customer_access_management.name]
}

##### ILB Health Check
#NOTE: https://cloud.google.com/load-balancing/docs/health-check-concepts?&_ga=2.88374875.-1170855520.1643042064#ip-ranges
module "context_gcp_firewall_customer_ilb_health_check" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.module_context.context
  name        = "ilb-health-check"
  description = "Allow GCP health check"
}
resource "google_compute_firewall" "customer_ilb_health_check" {
  name        = module.context_gcp_firewall_customer_ilb_health_check.name
  description = module.context_gcp_firewall_customer_ilb_health_check.description
  network     = google_compute_network.customer.name

  allow {
    protocol = "all"
  }

  source_ranges = var.health_check_ip_source
  target_tags   = [module.context_gcp_firewall_customer_ilb_health_check.name]
}
