
/*
  Description: Creates the VPC Peer between Customer and Management VPC
  Comments: N/A
*/

resource "aws_vpc_peering_connection" "customer" {
  peer_vpc_id = local.management_layer_00_outputs.vpc_main01.id
  vpc_id      = local.edge_vpc_layer_00_outputs.vpc_main01.id
  auto_accept = true

  tags = merge(module.base_layer_context.tags, {
    Name        = "${local.management_layer_00_outputs.vpc_main01.name}/${local.edge_vpc_layer_00_outputs.vpc_main01.name} peer"
    Description = "Management / ${module.base_layer_context.environment_values.kv.prefix_friendly_name} VPC Peer"
  })
}
