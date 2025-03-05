/*
  Description: Create the Internet and Nat Gateways for the Management VPC
  Comments: N/A
*/

##### customer_igw
resource "aws_internet_gateway" "customer_igw" {
  vpc_id = aws_vpc.customer.id
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
##### End customer_igw

##### customer_ngw
locals {
  nat_gateway_map = var.custom_no_nat_gateways == false ? { for key, value in local.subnet_edge_map : value.zone => key } : {}
}

resource "aws_eip" "main" {
  for_each = local.nat_gateway_map
  domain   = "vpc"
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
  depends_on = [aws_internet_gateway.customer_igw]
}

resource "aws_nat_gateway" "main" {
  for_each      = local.nat_gateway_map
  allocation_id = aws_eip.main[each.key].id
  subnet_id     = aws_subnet.customer_subnets[each.value].id
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
##### End customer_ngw
