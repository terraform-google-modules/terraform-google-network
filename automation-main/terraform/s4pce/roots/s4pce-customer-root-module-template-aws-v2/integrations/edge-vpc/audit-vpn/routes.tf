/*
  Description: Handles VPC routing creation
  Dependencies:
*/

resource "aws_route" "main01_default_route_igw" {
  route_table_id         = local.edge_vpc_layer_00_outputs.route_table_main01_default.id
  gateway_id             = aws_internet_gateway.main01.id
  destination_cidr_block = "0.0.0.0/0"
}
