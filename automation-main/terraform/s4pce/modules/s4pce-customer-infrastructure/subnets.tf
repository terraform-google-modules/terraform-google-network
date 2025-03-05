/*
  Description: Creates the Customer VPC subnets; Creates basic subnets.  Subnets in other availabilty zones are commented out.
  Comments:
    Subnets:
      customer_production_1a
      customer_production_1b
      customer_production_1c
      customer_quality_assurance_1a
      customer_quality_assurance_1b
      customer_quality_assurance_1c
      customer_development_1a
      customer_development_1b
      customer_development_1c
      customer_edge_1a
      customer_edge_1b
      customer_edge_1c
*/


##### Production Subnets
resource "aws_subnet" "customer_production_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}a"
  cidr_block              = var.subnet_production_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-production"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Production"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_production_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}b"
  cidr_block              = var.subnet_production_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-production"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Production"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_production_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = var.useZoneD ? "${module.base_layer_context.region}d" : "${module.base_layer_context.region}c"
  cidr_block              = var.subnet_production_1c_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-production"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1c Production"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
##### End Production Subnets


##### Quality-Assurance Subnets
resource "aws_subnet" "customer_quality_assurance_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}a"
  cidr_block              = var.subnet_quality_assurance_1a_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-quality-assurance"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Quality-Assurance"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_quality_assurance_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}b"
  cidr_block              = var.subnet_quality_assurance_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-quality-assurance"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Quality-Assurance"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_quality_assurance_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = var.useZoneD ? "${module.base_layer_context.region}d" : "${module.base_layer_context.region}c"
  cidr_block              = var.subnet_quality_assurance_1c_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-quality-assurance"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1c Quality-Assurance"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
##### End Quality-Assurance Subnets


##### Development Subnets
resource "aws_subnet" "customer_development_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}a"
  cidr_block              = var.subnet_development_1a_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-development"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Development"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_development_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}b"
  cidr_block              = var.subnet_development_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-development"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Development"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_development_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = var.useZoneD ? "${module.base_layer_context.region}d" : "${module.base_layer_context.region}c"
  cidr_block              = var.subnet_development_1c_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-development"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1c Development"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
##### End Development Subnets


##### Edge Subnets
resource "aws_subnet" "customer_edge_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}a"
  cidr_block              = var.subnet_edge_1a_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1a-edge"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1a Edge"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_edge_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${module.base_layer_context.region}b"
  cidr_block              = var.subnet_edge_1b_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1b-edge"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1b Edge"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_subnet" "customer_edge_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = var.useZoneD ? "${module.base_layer_context.region}d" : "${module.base_layer_context.region}c"
  cidr_block              = var.subnet_edge_1c_cidr_block
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1c-edge"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1c Edge"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
##### End Edge Subnets
