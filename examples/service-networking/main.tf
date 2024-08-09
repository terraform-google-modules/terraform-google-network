resource "google_compute_network" "peering_network" {
  name                    = "private-network"
  auto_create_subnetworks = "false"
}

module "service_networking" {
  source  = "terraform-google-modules/network/google//modules/service-networking"
  version = "~> 9.0"

  project_id   = var.project_id
  network_id   = google_compute_network.peering_network.id
  address_name = "global-address"
}
