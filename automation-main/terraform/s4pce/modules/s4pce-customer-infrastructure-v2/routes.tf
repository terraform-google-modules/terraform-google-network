/*
  Description: Route table and Routes
  Comments:
    Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.

    Routes:
      customer_default_route
      customer_nat
*/

##### customer_default_route
resource "aws_default_route_table" "customer_default_route" {
  default_route_table_id = aws_vpc.customer.default_route_table_id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
resource "aws_route" "customer_default_igw" {
  # NOTE,  Not changing or messing with the IGW as that will likely break other stuff.
  route_table_id         = aws_vpc.customer.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.customer_igw.id
}
resource "aws_vpc_endpoint_route_table_association" "customer_default_route" {
  route_table_id  = aws_vpc.customer.default_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}

resource "aws_vpc_endpoint_route_table_association" "additional_endpoints_routes_default" {
  for_each = toset(var.additional_endpoints)

  route_table_id  = aws_vpc.customer.default_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.additional_endpoints[each.key].id
}
##### End customer_default_route

#### Customer Nat Gateway Route Table, Routes, and Associations
resource "aws_route_table" "customer_nat" {
  for_each = toset(local.unique_zones)
  vpc_id   = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1${each.key}"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1${each.key}"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
resource "aws_route" "customer_nat" {
  for_each               = local.nat_gateway_map
  route_table_id         = aws_route_table.customer_nat[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[each.key].id
}
resource "aws_route_table_association" "customer_subnets" {
  for_each       = local.subnet_nonedge_map
  subnet_id      = aws_subnet.customer_subnets[each.key].id
  route_table_id = aws_route_table.customer_nat[each.value.zone].id
}
resource "aws_vpc_endpoint_route_table_association" "customer_nat" {
  for_each        = local.nat_gateway_map
  route_table_id  = aws_route_table.customer_nat[each.key].id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}
