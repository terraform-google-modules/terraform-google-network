/*
  Description: Handles creation of Cloud Router resources
*/

##### Cloud Routers
module "context_customer_router" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "router"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Router"
}

resource "google_compute_router" "customer" {
  name        = module.context_customer_router.name
  description = module.context_customer_router.description
  region      = module.module_context.region
  network     = google_compute_network.customer.id
  bgp {
    asn               = var.router_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

#### Google Compute Addresses
module "context_ip_customer_ngw" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "router"
  description = "Google Compute Address for ${module.module_context.environment_values.kv.prefix_friendly_name} router"
}
resource "google_compute_address" "customer_ngw" {
  name        = module.context_ip_customer_ngw.name
  description = module.context_ip_customer_ngw.description
  region      = module.module_context.region
}

##### NAT Gateway Configurations
module "context_customer_ngw" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "ngw"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} NAT Gateway"
}

resource "google_compute_router_nat" "customer_ngw" {
  name   = module.context_customer_ngw.name
  router = google_compute_router.customer.name
  region = google_compute_router.customer.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.customer_ngw.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.customer_edge
    content {
      name                    = subnetwork.value.id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.customer_development
    content {
      name                    = subnetwork.value.id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.customer_quality_assurance
    content {
      name                    = subnetwork.value.id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.customer_production
    content {
      name                    = subnetwork.value.id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}
