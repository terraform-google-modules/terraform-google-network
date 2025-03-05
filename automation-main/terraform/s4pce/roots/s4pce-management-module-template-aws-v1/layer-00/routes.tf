/*
  Description: Handles VPC routing
  Comments: Use individual route declarations instead of hardcoded route tables. If managed via route table, this will wholesale wipe out undocumented routes.
*/

### Default Route Table
resource "aws_default_route_table" "main01_default" {
  default_route_table_id = aws_vpc.main01.default_route_table_id
  propagating_vgws = [
  ]
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default-route"
    Description = "Default Route Table"
  })
  lifecycle {
    ignore_changes = [
      propagating_vgws,
    ]
  }
}
resource "aws_route" "main01_default_route_igw" {
  route_table_id         = aws_vpc.main01.default_route_table_id
  gateway_id             = aws_internet_gateway.main01.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_vpc_endpoint_route_table_association" "main01_default_s3" {
  route_table_id  = aws_vpc.main01.default_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}


##### Nat Gateway Route Tables
### main01_edge_1a
resource "aws_route_table" "main01_nat_edge_1a" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-private-1a"
    Description = "Route table for private subnet 1a"
  })
}
resource "aws_route" "main01_nat_edge_1a_route" {
  route_table_id         = aws_route_table.main01_nat_edge_1a.id
  nat_gateway_id         = aws_nat_gateway.main01_nat_edge_1a.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "main01_infrastructure_1a" {
  subnet_id      = aws_subnet.main01_infrastructure_1a.id
  route_table_id = aws_route_table.main01_nat_edge_1a.id
}
resource "aws_vpc_endpoint_route_table_association" "main01_infrastructure_1a_s3" {
  route_table_id  = aws_route_table.main01_nat_edge_1a.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
### main01_edge_1a

### main01_edge_1b
resource "aws_route_table" "main01_nat_edge_1b" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-private-1b"
    Description = "Route table for private subnet 1b"
  })
}
resource "aws_route" "main01_nat_edge_1b_route" {
  route_table_id         = aws_route_table.main01_nat_edge_1b.id
  nat_gateway_id         = aws_nat_gateway.main01_nat_edge_1b.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "main01_infrastructure_1b" {
  subnet_id      = aws_subnet.main01_infrastructure_1b.id
  route_table_id = aws_route_table.main01_nat_edge_1b.id
}
resource "aws_vpc_endpoint_route_table_association" "main01_infrastructure_1b_s3" {
  route_table_id  = aws_route_table.main01_nat_edge_1b.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
### main01_edge_1b

### main01_edge_1c
resource "aws_route_table" "main01_nat_edge_1c" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-private-1c"
    Description = "Route table for private subnet 1c"
  })
}
resource "aws_route" "main01_nat_edge_1c_route" {
  route_table_id         = aws_route_table.main01_nat_edge_1c.id
  nat_gateway_id         = aws_nat_gateway.main01_nat_edge_1c.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "main01_infrastructure_1c" {
  subnet_id      = aws_subnet.main01_infrastructure_1c.id
  route_table_id = aws_route_table.main01_nat_edge_1c.id
}
resource "aws_vpc_endpoint_route_table_association" "main01_infrastructure_1c_s3" {
  route_table_id  = aws_route_table.main01_nat_edge_1c.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
### end main01_edge_1c
