/*
  Description: Handles VPC subnet creation; Creates basic subnets accross default availabilty zones
  Layer: 00
  Dependencies:
    layer-00: vpc
  Comments:
    Defined Subnets:
      main01_infrastructure_1a
      main01_infrastructure_1b
      main01_infrastructure_1c
*/

### Infrastructure Subnets
resource "aws_subnet" "main01_infrastructure_1a" {
  vpc_id                  = aws_vpc.main01.id
  availability_zone       = "${module.base_layer_context.region}a"
  cidr_block              = var.subnet_main01_infrastructure_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-infrastructure"
    Description = "Private Infrastructure Az1a Subnet"
  })
}

resource "aws_subnet" "main01_infrastructure_1b" {
  vpc_id                  = aws_vpc.main01.id
  availability_zone       = "${module.base_layer_context.region}b"
  cidr_block              = var.subnet_main01_infrastructure_1b_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-infrastructure"
    Description = "Private Infrastructure Az1b Subnet"
  })
}

resource "aws_subnet" "main01_infrastructure_1c" {
  vpc_id                  = aws_vpc.main01.id
  availability_zone       = "${module.base_layer_context.region}c"
  cidr_block              = var.subnet_main01_infrastructure_1c_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-infrastructure"
    Description = "Private Infrastructure Az1c Subnet"
  })
}
### End Infrastructure Subnets
