/*
  Description: Route table and Routes
  Comments:
    Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.

    Routes:
      customer_default_route
      customer_ngw1a
      customer_ngw1b
      customer_ngw1c
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

# resource "aws_vpc_endpoint_route_table_association" "additional_endpoints_routes_default" {
#   for_each = toset(var.additional_endpoints)

#   route_table_id  = aws_vpc.customer.default_route_table_id
#   vpc_endpoint_id = aws_vpc_endpoint.additional_endpoints[each.key].id
# }
##### End customer_default_route


##### customer_ngw1a
resource "aws_route_table" "customer_ngw1a" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1a"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1a"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
resource "aws_route" "customer_ngw1a" {
  count                  = var.custom_no_nat_gateways == false ? 1 : 0
  route_table_id         = aws_route_table.customer_ngw1a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.customer_ngw1a[0].id
}
resource "aws_route_table_association" "customer_production_1a" {
  subnet_id      = aws_subnet.customer_production_1a.id
  route_table_id = aws_route_table.customer_ngw1a.id
}
resource "aws_route_table_association" "customer_quality_assurance_1a" {
  subnet_id      = aws_subnet.customer_quality_assurance_1a.id
  route_table_id = aws_route_table.customer_ngw1a.id
}
resource "aws_route_table_association" "customer_development_1a" {
  subnet_id      = aws_subnet.customer_development_1a.id
  route_table_id = aws_route_table.customer_ngw1a.id
}
resource "aws_vpc_endpoint_route_table_association" "customer_ngw1a" {
  route_table_id  = aws_route_table.customer_ngw1a.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}

# resource "aws_vpc_endpoint_route_table_association" "additional_endpoints_routes_ngw1a" {
#   for_each = toset(var.additional_endpoints)

#   route_table_id  = aws_route_table.customer_ngw1a.id
#   vpc_endpoint_id = aws_vpc_endpoint.additional_endpoints[each.key].id
# }
##### End customer_ngw1a


##### customer_ngw1b
resource "aws_route_table" "customer_ngw1b" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1b"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1b"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
resource "aws_route" "customer_ngw1b" {
  count                  = var.custom_no_nat_gateways == false ? 1 : 0
  route_table_id         = aws_route_table.customer_ngw1b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.customer_ngw1b[0].id
}
resource "aws_route_table_association" "customer_production_1b" {
  subnet_id      = aws_subnet.customer_production_1b.id
  route_table_id = aws_route_table.customer_ngw1b.id
}
resource "aws_route_table_association" "customer_quality_assurance_1b" {
  subnet_id      = aws_subnet.customer_quality_assurance_1b.id
  route_table_id = aws_route_table.customer_ngw1b.id
}
resource "aws_route_table_association" "customer_development_1b" {
  subnet_id      = aws_subnet.customer_development_1b.id
  route_table_id = aws_route_table.customer_ngw1b.id
}
resource "aws_vpc_endpoint_route_table_association" "customer_ngw1b" {
  route_table_id  = aws_route_table.customer_ngw1b.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}

# resource "aws_vpc_endpoint_route_table_association" "additional_endpoints_routes_ngw1b" {
#   for_each = toset(var.additional_endpoints)

#   route_table_id  = aws_route_table.customer_ngw1b.id
#   vpc_endpoint_id = aws_vpc_endpoint.additional_endpoints[each.key].id
# }
##### End customer_ngw1b


##### customer_ngw1c
resource "aws_route_table" "customer_ngw1c" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1c"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1c"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
resource "aws_route" "customer_ngw1c" {
  count                  = var.custom_no_nat_gateways == false ? 1 : 0
  route_table_id         = aws_route_table.customer_ngw1c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.customer_ngw1c[0].id
}
resource "aws_route_table_association" "customer_production_1c" {
  subnet_id      = aws_subnet.customer_production_1c.id
  route_table_id = aws_route_table.customer_ngw1c.id
}
resource "aws_route_table_association" "customer_quality_assurance_1c" {
  subnet_id      = aws_subnet.customer_quality_assurance_1c.id
  route_table_id = aws_route_table.customer_ngw1c.id
}
resource "aws_route_table_association" "customer_development_1c" {
  subnet_id      = aws_subnet.customer_development_1c.id
  route_table_id = aws_route_table.customer_ngw1c.id
}
resource "aws_vpc_endpoint_route_table_association" "customer_ngw1c" {
  route_table_id  = aws_route_table.customer_ngw1c.id
  vpc_endpoint_id = aws_vpc_endpoint.private_s3.id
}

# resource "aws_vpc_endpoint_route_table_association" "additional_endpoints_routes_ngw1c" {
#   for_each = toset(var.additional_endpoints)

#   route_table_id  = aws_route_table.customer_ngw1c.id
#   vpc_endpoint_id = aws_vpc_endpoint.additional_endpoints[each.key].id
# }
##### End customer_ngw1c
