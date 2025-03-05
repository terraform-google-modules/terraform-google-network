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

#### Create EIPs for NAT Gateways
resource "aws_eip" "vpc_ngw1_eip" {
  vpc = true
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1a"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1a"
  })
  depends_on = [aws_internet_gateway.customer_igw]
}

resource "aws_eip" "vpc_ngw2_eip" {
  vpc = true
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1b"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1b"
  })
  depends_on = [aws_internet_gateway.customer_igw]
}
# end EIP creation

# Create NGWs per AZ
resource "aws_nat_gateway" "customer_ngw1" {
  allocation_id = aws_eip.vpc_ngw1_eip.id
  subnet_id     = aws_subnet.customer_edge_1a.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1a"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1a"
  })
}

resource "aws_nat_gateway" "customer_ngw2" {
  allocation_id = aws_eip.vpc_ngw2_eip.id
  subnet_id     = aws_subnet.customer_edge_1b.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw1b"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Nat Gateway 1b"
  })
}
#end NGWs
