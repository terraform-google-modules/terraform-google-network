/*
  Description: Creates the Customer VPC; Creates VPC and updates DHCP options with DNS servers from Directory Services. Also adds private s3 endpoint
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
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} VPC"
  })
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.customer.id
  dhcp_options_id = var.vpc_dhcp_options_id == "" ? data.aws_vpc.management.dhcp_options_id : var.vpc_dhcp_options_id
}

###### Management VPC Metadata
data "aws_vpc" "management" {
  tags = {
    Name = var.management_vpc_name
  }
}

resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = aws_vpc.customer.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.resource_prefix
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} S3 Endpoint"
  })
}
