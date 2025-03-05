
/*
  Description: Creates the VPC Peer between Customer and Management VPC
  Comments: N/A
*/

resource "aws_vpc_peering_connection" "customer" {
  peer_vpc_id = data.aws_vpc.management.id
  vpc_id      = aws_vpc.customer.id
  auto_accept = true
  tags = merge(module.base_layer_context.tags, {
    Name        = "${data.aws_vpc.management.tags.Name}/${var.vpc_custom_name} peer"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Peer with Management VPC"
  })
}
