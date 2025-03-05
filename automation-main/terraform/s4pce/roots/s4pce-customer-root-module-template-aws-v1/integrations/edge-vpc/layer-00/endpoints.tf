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

locals {
  # Parse the instance list and creates a new list of instances that have `endpoint_port_list` defined
  endpoint_list = { for key, value in local.layer_02_outputs.raw_instance_list : key => value if lookup(value, "endpoint_port_list", []) != [] }
}

# This module creates NLB's in the backend that have a dynamic list of listeners and targegroups
# from the NLB's, endpoint services are created. Endpoints are then created to consume the Endpoint service.
module "endpoint_list" {
  for_each = local.endpoint_list
  source   = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/aws-endpoint-services-multiport"
  context  = module.base_layer_context.context
  nlb_subnet_list = [
    local.layer_00_outputs.infrastructure["subnet_${replace(lower(each.value.landscape), "-", "_")}_1a"].id,
    local.layer_00_outputs.infrastructure["subnet_${replace(lower(each.value.landscape), "-", "_")}_1b"].id,
    local.layer_00_outputs.infrastructure["subnet_${replace(lower(each.value.landscape), "-", "_")}_1c"].id,
  ]
  nlb_name             = "${lower(each.key)}-nlb-edge"
  nlb_port_list        = each.value.endpoint_port_list
  nlb_target_id        = local.layer_02_outputs.instance_list[each.key].instance_id
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
