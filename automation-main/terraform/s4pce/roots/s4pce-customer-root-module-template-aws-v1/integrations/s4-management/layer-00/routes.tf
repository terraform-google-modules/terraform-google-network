/*
  Description: Create the routes for the Customer VPC; Updates the routes for both Customer and Management VPCs for peering information
  Comments: Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.
*/

##### Update Management Routes
resource "aws_route" "management_default_customer_peer" {
  route_table_id            = local.management_layer_00_outputs.route_table_main01_default.id
  destination_cidr_block    = local.layer_00_outputs.infrastructure.vpc_customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "management_nat_customer_peer_1a" {
  route_table_id            = local.management_layer_00_outputs.route_table_main01_nat_edge_1a.id
  destination_cidr_block    = local.layer_00_outputs.infrastructure.vpc_customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "management_nat_customer_peer_1b" {
  route_table_id            = local.management_layer_00_outputs.route_table_main01_nat_edge_1b.id
  destination_cidr_block    = local.layer_00_outputs.infrastructure.vpc_customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "management_nat_customer_peer_1c" {
  route_table_id            = local.management_layer_00_outputs.route_table_main01_nat_edge_1c.id
  destination_cidr_block    = local.layer_00_outputs.infrastructure.vpc_customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}
##### End Update Management Routes


##### Update Customer Routes
resource "aws_route" "customer_default_management_peer" {
  route_table_id            = local.layer_00_outputs.infrastructure.route_table_default.id
  destination_cidr_block    = local.management_layer_00_outputs.vpc_main01.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "customer_nat_management_peer_1a" {
  route_table_id            = local.layer_00_outputs.infrastructure.route_table_customer_ngw1a.id
  destination_cidr_block    = local.management_layer_00_outputs.vpc_main01.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "customer_nat_management_peer_1b" {
  route_table_id            = local.layer_00_outputs.infrastructure.route_table_customer_ngw1b.id
  destination_cidr_block    = local.management_layer_00_outputs.vpc_main01.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route" "customer_nat_management_peer_1c" {
  route_table_id            = local.layer_00_outputs.infrastructure.route_table_customer_ngw1c.id
  destination_cidr_block    = local.management_layer_00_outputs.vpc_main01.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}
##### End Update Customer Routes
