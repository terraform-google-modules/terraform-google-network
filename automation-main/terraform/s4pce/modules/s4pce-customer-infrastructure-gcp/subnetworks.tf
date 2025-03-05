/*
  Description: Handles VPC subnetwork creation
*/

##### Production Subnets
module "context_subnetworks_customer_production" {
  for_each = var.subnets.production
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context

  name        = "az${each.key}-production"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Az${each.key} Production"
}

resource "google_compute_subnetwork" "customer_production" {
  for_each      = var.subnets.production
  name          = module.context_subnetworks_customer_production[each.key].name
  description   = module.context_subnetworks_customer_production[each.key].description
  ip_cidr_range = each.value
  region        = module.module_context.region
  network       = google_compute_network.customer.id
  log_config {
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
  }
}

##### Quality Asssurance Subnets
module "context_subnetworks_customer_quality_assurance" {
  for_each = var.subnets.quality_assurance
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context

  name        = "az${each.key}-quality-assurance"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Az${each.key} Quality-Assurance"
}

resource "google_compute_subnetwork" "customer_quality_assurance" {
  for_each      = var.subnets.quality_assurance
  name          = module.context_subnetworks_customer_quality_assurance[each.key].name
  description   = module.context_subnetworks_customer_quality_assurance[each.key].description
  ip_cidr_range = each.value
  region        = module.module_context.region
  network       = google_compute_network.customer.id
  log_config {
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
  }
}

##### Development Subnets
module "context_subnetworks_customer_development" {
  for_each = var.subnets.development
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context

  name        = "az${each.key}-development"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Az${each.key} Development"
}

resource "google_compute_subnetwork" "customer_development" {
  for_each      = var.subnets.development
  name          = module.context_subnetworks_customer_development[each.key].name
  description   = module.context_subnetworks_customer_development[each.key].description
  ip_cidr_range = each.value
  region        = module.module_context.region
  network       = google_compute_network.customer.id
  log_config {
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
  }
}

### Edge Subnets
module "context_subnetworks_customer_edge" {
  for_each = var.subnets.edge
  source   = "../../../shared/modules/terraform-null-context/modules/legacy"
  context  = module.module_context.context

  name        = "az${each.key}-edge"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Az${each.key} Production"
}

resource "google_compute_subnetwork" "customer_edge" {
  for_each      = var.subnets.edge
  name          = module.context_subnetworks_customer_edge[each.key].name
  description   = module.context_subnetworks_customer_edge[each.key].description
  ip_cidr_range = each.value
  region        = module.module_context.region
  network       = google_compute_network.customer.id
  log_config {
    aggregation_interval = var.log_aggregation_interval
    flow_sampling        = var.log_flow_sampling
  }
}
