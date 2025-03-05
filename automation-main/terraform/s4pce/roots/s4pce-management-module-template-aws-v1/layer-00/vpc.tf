/*
  Description: Handles VPC creation
  Comments: N/A
*/

##### VPC Creation
resource "aws_vpc" "main01" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.resource_prefix
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} VPC"
  })
}

##### Update DHCP Options
resource "aws_vpc_dhcp_options" "main01" {
  domain_name         = var.dns_fqdn
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-dhcp-options"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} DHCP Options"
  })
}

resource "aws_vpc_dhcp_options_association" "main01" {
  vpc_id          = aws_vpc.main01.id
  dhcp_options_id = aws_vpc_dhcp_options.main01.id
}

##### Create VPC Endpoint
resource "aws_vpc_endpoint" "private_s3" {
  vpc_id       = aws_vpc.main01.id
  service_name = "com.amazonaws.${module.base_layer_context.region}.s3"
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-s3"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} S3"
  })
}
