/*
  Description: Handles VPC routing creation
  Layer: 00
  Dependencies:
    layer-00: vpc, subnets, gateways
  Comments: Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.
    Route Tables:
      shoot_default
*/

### Default Route Table
resource "aws_default_route_table" "shoot_default" {
  default_route_table_id = aws_vpc.shoot.default_route_table_id
  propagating_vgws       = []
  tags = {
    Name        = "${local.layer_resource_prefix}-default-route"
    Description = "Default Route Table"
  }
  lifecycle {
    ignore_changes = [
      propagating_vgws,
    ]
  }
}

### Shoot IGW Route
resource "aws_route" "shoot_default_route_igw" {
  route_table_id         = aws_vpc.shoot.default_route_table_id
  gateway_id             = aws_internet_gateway.shoot_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

locals {
  management_route_updates = {
    route_table_main01_default     = local.layer_00_outputs.route_table_main01_default.id
    route_table_main01_nat_edge_1a = local.layer_00_outputs.route_table_main01_nat_edge_1a.id
    route_table_main01_nat_edge_1b = local.layer_00_outputs.route_table_main01_nat_edge_1b.id
    route_table_main01_nat_edge_1c = local.layer_00_outputs.route_table_main01_nat_edge_1c.id
  }
}
##### VPC Peering - Update Management Routes
resource "aws_route" "management_route" {
  for_each                  = local.management_route_updates
  route_table_id            = each.value
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.shoot.id
}


##### VPC Peering - Update Shoot Routes
resource "aws_route" "shoot_default_management_peer" {
  route_table_id            = aws_default_route_table.shoot_default.id
  destination_cidr_block    = local.layer_00_outputs.vpc_main01.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.shoot.id
}


##### Secondary Subnet Routing
resource "aws_route_table" "secondary_subnets" {
  vpc_id = aws_vpc.shoot.id
  route { # NOTE: Only route to local
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  route { # NOTE: Only route to local
    cidr_block = var.vpc_secondary_cidr_block
    gateway_id = "local"
  }
  route { # NOTE: Only route to local
    ipv6_cidr_block = aws_vpc.shoot.ipv6_cidr_block
    gateway_id      = "local"
  }
}

resource "aws_route_table_association" "secondary_subnets" {
  for_each       = aws_subnet.secondary_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.secondary_subnets.id
}
