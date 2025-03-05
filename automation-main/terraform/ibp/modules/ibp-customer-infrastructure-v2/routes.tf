/*
  Description: Create the routes for the Customer VPC; Updates the routes for both Customer and Management VPCs for peering information
  Comments: Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.
*/

##### Management Route Table Metadata
data "aws_route_table" "management_nat" {
  vpc_id = data.aws_vpc.management.id
  tags = {
    Name = "${data.aws_vpc.management.tags.Name}-${var.management_nat_name}"
  }
}

##### Update Management Routes
resource "aws_route" "management_default_customer_peer" {
  route_table_id            = data.aws_vpc.management.main_route_table_id
  destination_cidr_block    = aws_vpc.customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
  # depends_on                = [aws_route_table.testing]
}

resource "aws_route" "management_nat_customer_peer" {
  route_table_id            = data.aws_route_table.management_nat.id
  destination_cidr_block    = aws_vpc.customer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
  # depends_on                = [aws_route_table.testing]
}

##### Customer Default Route Tables and Routes
resource "aws_default_route_table" "customer_default_route" {
  default_route_table_id = aws_vpc.customer.default_route_table_id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default"
  })
}

resource "aws_route" "customer_default_igw" {
  route_table_id         = aws_vpc.customer.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.customer_igw.id
}

resource "aws_route" "customer_default_management_peer" {
  route_table_id            = aws_vpc.customer.default_route_table_id
  destination_cidr_block    = data.aws_vpc.management.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_vpc_endpoint_route_table_association" "customer_default_route" {
  route_table_id  = aws_vpc.customer.default_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
##### End Customer Default Route Tables and Routes

##### Customer Nat Gateway Route Table, Routes, and Associations
resource "aws_route_table" "customer_nat_gateway_route" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1a"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1a"
  })
}

resource "aws_route_table" "customer_nat_gateway_route_b" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1b"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1b"
  })
}

resource "aws_route" "customer_nat_gateway" {
  route_table_id         = aws_route_table.customer_nat_gateway_route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.customer_ngw1.id
}

resource "aws_route" "customer_nat_gateway_b" {
  route_table_id         = aws_route_table.customer_nat_gateway_route_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.customer_ngw2.id
}

resource "aws_route" "customer_nat_gateway_management_peer" {
  route_table_id            = aws_route_table.customer_nat_gateway_route.id
  destination_cidr_block    = data.aws_vpc.management.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.customer.id
}

resource "aws_route_table_association" "customer_production_1a" {
  subnet_id      = aws_subnet.customer_production_1a.id
  route_table_id = aws_route_table.customer_nat_gateway_route.id
}

resource "aws_route_table_association" "customer_production_1b" {
  subnet_id      = aws_subnet.customer_production_1b.id
  route_table_id = aws_route_table.customer_nat_gateway_route_b.id
}

resource "aws_route_table_association" "customer_dataservices_1a" {
  subnet_id      = aws_subnet.customer_dataservices_1a.id
  route_table_id = aws_route_table.customer_nat_gateway_route.id
}

resource "aws_route_table_association" "customer_dataservices_1b" {
  subnet_id      = aws_subnet.customer_dataservices_1b.id
  route_table_id = aws_route_table.customer_nat_gateway_route_b.id
}

resource "aws_route_table_association" "customer_staging_1a" {
  subnet_id      = aws_subnet.customer_staging_1a.id
  route_table_id = aws_route_table.customer_nat_gateway_route.id
}

resource "aws_vpc_endpoint_route_table_association" "customer_nat_gateway_route" {
  route_table_id  = aws_route_table.customer_nat_gateway_route.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
##### End Customer Nat Gateway Route Table, Routes, and Associations
