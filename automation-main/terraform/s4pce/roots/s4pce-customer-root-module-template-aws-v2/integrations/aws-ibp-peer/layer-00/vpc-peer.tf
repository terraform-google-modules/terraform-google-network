
/*
  Description: Creates the VPC Peer between Customer and Management VPC
  Comments: N/A
*/

resource "aws_vpc_peering_connection" "main01" {
  vpc_id        = local.layer_00.infrastructure.vpc_customer.id
  peer_vpc_id   = local.ibp_customer.layer_00.infrastructure.vpc_customer_id
  peer_owner_id = data.aws_caller_identity.ibp.account_id

  auto_accept = false

  tags = merge(module.base_layer_context.tags, {
    Name        = "${local.layer_00.infrastructure.vpc_customer.name}/${local.ibp_customer.layer_00.infrastructure.vpc_customer_name} peer"
    Description = "${local.ibp_customer.layer_00._context.environment_values.kv.prefix_friendly_name} / ${module.base_layer_context.environment_values.kv.prefix_friendly_name} VPC Peer"
  })
}

resource "aws_vpc_peering_connection_accepter" "main01" {
  provider                  = aws.ibp
  vpc_peering_connection_id = aws_vpc_peering_connection.main01.id
  auto_accept               = true

  tags = merge(module.base_layer_context.tags, {
    Name        = "${local.layer_00.infrastructure.vpc_customer.name}/${local.ibp_customer.layer_00.infrastructure.vpc_customer_name} peer"
    Description = "${local.ibp_customer.layer_00._context.environment_values.kv.prefix_friendly_name} / ${module.base_layer_context.environment_values.kv.prefix_friendly_name} VPC Peer"
  })
}
