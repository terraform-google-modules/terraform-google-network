/*
  Description: Creates VPC endpoints for the Customer
    Parses the raw instance list for instances that have the `endpoint_port_list` value defined.
    Of the instances with `endpoint_port_list` creates a NLB/Endpoint that passes the TCP Ports that are listed.
  Layer: 00
  Dependencies:
    layer-00: infrastructure
    layer-02: layer 02 outputs
  Comments: None
*/

# locals {
#   # Parse the instance list and creates a new list of instances that have `endpoint_port_list` defined
#   endpoint_list = { for key, value in local.layer_02_outputs.s4pce_customer_instances.raw_instance_list : key => value if lookup(value, "endpoint_port_list", []) != [] }
# }

# This module creates NLB's in the backend that have a dynamic list of listeners and targegroups
# from the NLB's, endpoint services are created. Endpoints are then created to consume the Endpoint service.

locals {
  subnet_primary_landscape_ids = [
    for key, value in local.layer_00_outputs.infrastructure.metadata.subnet_primary_landscape_map :
    local.layer_00_outputs.infrastructure.subnets["${key}"].id
  ]
}

module "ha_endpoints" {
  for_each             = var.ha_endpoints
  source               = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/aws-endpoint-services-multiport"
  context              = module.base_layer_context.context
  nlb_subnet_list      = local.subnet_primary_landscape_ids
  nlb_name             = "${lower(each.key)}-nlb-${lower(each.value.vhost)}"
  nlb_port_list        = each.value.ports
  nlb_target_id        = each.value.address
  nlb_target_ip        = true
  nlb_target_az_all    = true # needed because the VIP is not in the VPC CIDR
  endpoint_edge_vpc_id = aws_vpc.main01.id
  endpoint_security_group_list = [
    aws_security_group.main01_all_egress.id,
    aws_security_group.main01_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.main01_infrastructure_1a.id,
    aws_subnet.main01_infrastructure_1b.id,
    aws_subnet.main01_infrastructure_1c.id,
  ]
}
