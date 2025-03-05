/*
  Description: Creates the Customer VPC subnets; Creates basic subnets.  Subnets in other availabilty zones are commented out.
  Comments: N/A
*/

##### Private Production Subnets
resource "aws_subnet" "customer_production_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_production_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-production"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Production")
  })
}

resource "aws_subnet" "customer_production_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_production_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-production"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Production")
  })
}

##### Private DataServices Subnets
resource "aws_subnet" "customer_dataservices_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_dataservices_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-dataservices"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Dataservices")
  })
}

resource "aws_subnet" "customer_dataservices_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_dataservices_1b_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-dataservices"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Dataservices")
  })
}

##### Private staging Subnets
resource "aws_subnet" "customer_staging_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_staging_1a_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-staging"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Staging")
  })
}

##### Edge Subnets
resource "aws_subnet" "customer_edge_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_edge_1a_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-edge"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Edge")
  })
}

resource "aws_subnet" "customer_edge_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_edge_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-edge"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Edge")
  })
}

resource "aws_subnet" "customer_edge_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = var.aws_region != "ca-central-1" ? "${var.aws_region}c" : "${var.aws_region}d"
  cidr_block              = var.subnet_edge_1c_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-edge"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1c Edge")
  })
}

##### Prepopulated Subnets reserved for other availability zones.
# resource "aws_subnet" "customer_staging_1b" {
#   vpc_id            = aws_vpc.customer.id
#   availability_zone = "${ var.aws_region }b"
#   cidr_block        = var.subnet_staging_1b_cidr_block
#   map_public_ip_on_launch = false
#   tags = {
#     Name = "${ aws_vpc.customer.tags.Name }-az1b-staging"
#     Managed-By = "terraform"
#   }
#   lifecycle {
#     prevent_destroy = false
#   }
# }
