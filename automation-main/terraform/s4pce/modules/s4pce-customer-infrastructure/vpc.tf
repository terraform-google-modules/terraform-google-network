/*
  Description: Creates the Customer VPC
    Creates VPC and updates DHCP options with DNS servers from Directory Services.
    Also adds private s3 endpoint
  Comments: N/A
*/

###### VPC Creation
resource "aws_vpc" "customer" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.resource_prefix
    Description = module.base_layer_context.environment_values.kv.prefix_friendly_name
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.customer.id
  dhcp_options_id = var.vpc_dhcp_options_id
}

resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = aws_vpc.customer.id
  service_name = "com.amazonaws.${module.base_layer_context.region}.s3"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-s3"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} S3"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

# additional_endpoints

resource "aws_vpc_endpoint" "additional_endpoints" {
  for_each = var.additional_endpoints_creation ? toset(var.additional_endpoints) : []
  #for_each     = toset(var.additional_endpoints)
  vpc_id = aws_vpc.customer.id

  service_name        = "com.amazonaws.${module.base_layer_context.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-${each.value}"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} ${each.value}"
  })

  subnet_ids = [
    aws_subnet.customer_production_1a.id,
    aws_subnet.customer_production_1b.id,
    aws_subnet.customer_production_1c.id,
  ]
  security_group_ids = [aws_security_group.customer_vpc.id, ]
}
