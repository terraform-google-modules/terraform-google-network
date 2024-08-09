resource "google_compute_global_address" "global_address" {
  project       = var.project_id
  name          = var.address_name
  purpose       = var.address_purpose
  address_type  = var.address_type
  prefix_length = var.address_prefix_length
  network       = var.network_id
}

resource "google_service_networking_connection" "default" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.global_address.name]
  deletion_policy         = var.deletion_policy
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  count                = var.create_peering_routes_config ? 1 : 0
  project              = var.project_id
  peering              = google_service_networking_connection.default.peering
  network              = var.network_name
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}

resource "google_service_networking_peered_dns_domain" "default" {
  count      = var.create_peered_dns_domain ? 1 : 0
  project    = var.project_id
  name       = var.domain_name
  network    = var.network_name
  dns_suffix = var.dns_suffix
  service    = "servicenetworking.googleapis.com"
}
