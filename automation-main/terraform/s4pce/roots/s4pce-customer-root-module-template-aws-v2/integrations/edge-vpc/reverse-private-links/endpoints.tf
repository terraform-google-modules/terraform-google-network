/*
  Description: Creates VPC endpoints for the Customer
    Parses the reverse_private_link_list and creates endpoints for each
  Layer: edge-vpc layer 00
  Dependencies:
    edge_vpc_layer_00_outputs: vpc, subnets, security groups
  Comments: None
*/

# This module creates NLB's in the backend that have a dynamic list of listeners and targetgroups
# from the NLB's, endpoint services are created. Endpoints are then created to consume the Endpoint service.

locals {
  endpoint_edge_subnet_list = [
    for key, value in local.layer_00_outputs.infrastructure.metadata.subnet_edge_map :
    local.layer_00_outputs.infrastructure.subnets["${key}"].id
  ]
}

module "endpoint_list" {
  for_each = var.reverse_private_link_list
  source   = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/aws-endpoint-services-multiport"
  context  = module.base_layer_context.context
  nlb_subnet_list = [
    local.edge_vpc_layer_00_outputs.subnet_main01_infrastructure_1a.id,
    local.edge_vpc_layer_00_outputs.subnet_main01_infrastructure_1b.id,
    local.edge_vpc_layer_00_outputs.subnet_main01_infrastructure_1c.id,
  ]
  nlb_name             = "${module.base_layer_context.customer}-rpl-${lower(each.key)}"
  nlb_port_list        = each.value.port_list
  nlb_target_id        = each.value.ip_address
  nlb_target_ip        = true
  nlb_target_az_all    = true
  endpoint_edge_vpc_id = local.layer_00_outputs.infrastructure.vpc_customer.id
  endpoint_security_group_list = [
    local.layer_00_outputs.infrastructure.security_group_vpc.id,
    local.layer_00_outputs.infrastructure.security_group_all_egress.id,
  ]
  endpoint_subnet_list = local.endpoint_edge_subnet_list
}
