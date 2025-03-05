/*
  Description: Terraform outputs
  Comments: N/A
*/

##### Filestore
##### Gateways
output "customer_router" { value = {
  name = google_compute_router.customer.name
  id   = google_compute_router.customer.id
  asn  = google_compute_router.customer.bgp[0].asn
} }

##### GCS
// output "gcs_backups" { value = google_storage_bucket.customer_backups.url }

##### Firewall
output "customer_firewall" { value = {
  "access_management"         = google_compute_firewall.access_management.name
  "customer_all_egress"       = google_compute_firewall.customer_all_egress.name
  "customer_vpc"              = google_compute_firewall.customer_vpc.name
  "customer_ilb_health_check" = google_compute_firewall.customer_ilb_health_check.name
} }


##### Subnets
output "subnet_production_1a" { value = {
  name = google_compute_subnetwork.customer_production["1a"].name
  id   = google_compute_subnetwork.customer_production["1a"].id
} }
output "subnet_production_1b" { value = {
  name = google_compute_subnetwork.customer_production["1b"].name
  id   = google_compute_subnetwork.customer_production["1b"].id
} }
output "subnet_production_1c" { value = {
  name = google_compute_subnetwork.customer_production["1c"].name
  id   = google_compute_subnetwork.customer_production["1c"].id
} }
output "subnet_development_1a" { value = {
  name = google_compute_subnetwork.customer_development["1a"].name
  id   = google_compute_subnetwork.customer_development["1a"].id
} }
output "subnet_development_1b" { value = {
  name = google_compute_subnetwork.customer_development["1b"].name
  id   = google_compute_subnetwork.customer_development["1b"].id
} }
output "subnet_development_1c" { value = {
  name = google_compute_subnetwork.customer_development["1c"].name
  id   = google_compute_subnetwork.customer_development["1c"].id
} }
output "subnet_quality_assurance_1a" { value = {
  name = google_compute_subnetwork.customer_quality_assurance["1a"].name
  id   = google_compute_subnetwork.customer_quality_assurance["1a"].id
} }
output "subnet_quality_assurance_1b" { value = {
  name = google_compute_subnetwork.customer_quality_assurance["1b"].name
  id   = google_compute_subnetwork.customer_quality_assurance["1b"].id
} }
output "subnet_quality_assurance_1c" { value = {
  name = google_compute_subnetwork.customer_quality_assurance["1c"].name
  id   = google_compute_subnetwork.customer_quality_assurance["1c"].id
} }
output "subnet_edge_1a" { value = {
  name = google_compute_subnetwork.customer_edge["1a"].name
  id   = google_compute_subnetwork.customer_edge["1a"].id
} }
output "subnet_edge_1b" { value = {
  name = google_compute_subnetwork.customer_edge["1b"].name
  id   = google_compute_subnetwork.customer_edge["1b"].id
} }
output "subnet_edge_1c" { value = {
  name = google_compute_subnetwork.customer_edge["1c"].name
  id   = google_compute_subnetwork.customer_edge["1c"].id
} }


#### GCN
output "vpc_customer" { value = {
  name = google_compute_network.customer.name
  id   = google_compute_network.customer.id
  cidr = var.gcn_cidr_block
} }

####  Service Account
output "service-account" { value = trimprefix(regex("/serviceAccounts/.*", google_service_account.service_account.name), "/serviceAccounts/") }
