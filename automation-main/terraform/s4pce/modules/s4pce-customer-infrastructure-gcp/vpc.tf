/*
  Description: Handles VPC creation
  Layer: 00
  Dependencies: none
  Comments: N/A
*/

##### VPCs
resource "google_compute_network" "customer" {
  name                    = module.module_context.resource_prefix
  description             = "${module.module_context.environment_values.kv.prefix_friendly_name} VPC"
  auto_create_subnetworks = false
}
