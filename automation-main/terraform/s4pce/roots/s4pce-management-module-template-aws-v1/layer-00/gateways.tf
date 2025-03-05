/*
  Description: Handles creation of Internet and Nat Gateways; Creates gateways and associated EIPs if necessary
  Comments:
*/

### Internet Gateway
resource "aws_internet_gateway" "main01" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-igw"
    Description = "Internet Gateway"
  })
}
### End Internet Gateway

##### Create Nat Gateways
### main01_edge_1a
resource "aws_nat_gateway" "main01_nat_edge_1a" {
  subnet_id     = aws_subnet.main01_edge_1a.id
  allocation_id = aws_eip.main01_nat_edge_1a.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1a"
    Description = "Nat Gateway 1a"
  })
}
resource "aws_eip" "main01_nat_edge_1a" {
  domain = "vpc"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1a"
    Description = "Nat Gateway 1a"
  })
  depends_on = [aws_internet_gateway.main01]
}

### main01_edge_1b
resource "aws_nat_gateway" "main01_nat_edge_1b" {
  subnet_id     = aws_subnet.main01_edge_1b.id
  allocation_id = aws_eip.main01_nat_edge_1b.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1b"
    Description = "Nat Gateway 1b"
  })
}
resource "aws_eip" "main01_nat_edge_1b" {
  domain = "vpc"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1b"
    Description = "Nat Gateway 1b"
  })
  lifecycle {
    prevent_destroy = false
  }
  depends_on = [aws_internet_gateway.main01]
}

### main01_edge_1c
resource "aws_nat_gateway" "main01_nat_edge_1c" {
  subnet_id     = aws_subnet.main01_edge_1c.id
  allocation_id = aws_eip.main01_nat_edge_1c.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1c"
    Description = "Nat Gateway 1c"
  })
}
resource "aws_eip" "main01_nat_edge_1c" {
  domain = "vpc"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ngw-1c"
    Description = "Nat Gateway 1c"
  })
  depends_on = [aws_internet_gateway.main01]
}
