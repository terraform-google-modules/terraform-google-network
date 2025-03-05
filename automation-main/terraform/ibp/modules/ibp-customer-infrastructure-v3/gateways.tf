/*
  Description: Create the Internet and Nat Gateways for the Management VPC
  Comments: N/A
*/

##### Create Internet Gateway
resource "aws_internet_gateway" "customer_igw" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default"
  })
}

##### Nat Gateways
locals {
  nat_gateway_map = {
    for key, value in local.subnet_edge_map : value.zone => key if(var.network.use_new_network_model) || (key != "edge_3")
  }
  # Exclude edge_3 if using the old network model.
}

resource "aws_eip" "main" {
  for_each = local.nat_gateway_map
  domain   = "vpc"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1${each.key}"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1${each.key}"
  })
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
}


output "nat_gateway_name" { value = var.network.use_new_network_model ? null : aws_nat_gateway.main["a"].tags.Name }
output "nat_gateway_eip" { value = var.network.use_new_network_model ? null : aws_eip.main["a"].public_ip }
output "nat_gateway_id" { value = var.network.use_new_network_model ? null : aws_nat_gateway.main["a"].id }

output "nat_gateway" { value = {
  for key, value in local.nat_gateway_map : key => {
    name = aws_nat_gateway.main[key].tags.Name
    id   = aws_nat_gateway.main[key].id
    eip  = aws_eip.main[key].public_ip
  }
} }
