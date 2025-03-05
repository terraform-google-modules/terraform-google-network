/*
  Description: Create the routes between the vpc-peer
  Comments: Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.
*/

resource "aws_route" "s4_vpc_routes" {
  for_each                  = local.layer_00.infrastructure.route_table
  route_table_id            = each.value.id
  destination_cidr_block    = local.ibp_customer.layer_00.infrastructure.vpc_customer_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.main01.id
}

resource "aws_route" "ibp_vpc_route" {
  provider                  = aws.ibp
  for_each                  = local.ibp_customer.layer_00.infrastructure.route_table
  route_table_id            = each.value.id
  destination_cidr_block    = local.layer_00.infrastructure.vpc_customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.main01.id
}
