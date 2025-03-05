/*
  Description: Create the Internet and Nat Gateways for the Management VPC
  Comments: N/A
    customer_igw
    customer_ngw1a
    customer_ngw1b
    customer_ngw1c
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


##### customer_ngw1a
resource "aws_eip" "customer_ngw1a" {
  count = var.custom_no_nat_gateways == false ? 1 : 0
  vpc   = true
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
  depends_on = [aws_internet_gateway.customer_igw]
}
resource "aws_nat_gateway" "customer_ngw1a" {
  count         = var.custom_no_nat_gateways == false ? 1 : 0
  allocation_id = aws_eip.customer_ngw1a[0].id
  subnet_id     = aws_subnet.customer_edge_1a.id
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
##### End customer_ngw1a


##### customer_ngw1b
resource "aws_eip" "customer_ngw1b" {
  count = var.custom_no_nat_gateways == false ? 1 : 0
  vpc   = true
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
  depends_on = [aws_internet_gateway.customer_igw]
}
resource "aws_nat_gateway" "customer_ngw1b" {
  count         = var.custom_no_nat_gateways == false ? 1 : 0
  allocation_id = aws_eip.customer_ngw1b[0].id
  subnet_id     = aws_subnet.customer_edge_1b.id
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
##### End customer_ngw1b


##### customer_ngw1c
resource "aws_eip" "customer_ngw1c" {
  count = var.custom_no_nat_gateways == false ? 1 : 0
  vpc   = true
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
  depends_on = [aws_internet_gateway.customer_igw]
}
resource "aws_nat_gateway" "customer_ngw1c" {
  count         = var.custom_no_nat_gateways == false ? 1 : 0
  allocation_id = aws_eip.customer_ngw1c[0].id
  subnet_id     = aws_subnet.customer_edge_1c.id
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
##### End customer_ngw1c
