/*
  Description: Handles VPC creation; Creates VPC and updates DHCP options with DNS servers from Directory Services
  Layer: 00
  Dependencies: none
  Comments: N/A
*/

##### VPC Creation
resource "aws_vpc" "main01" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.resource_prefix
    Description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} VPC"
  })
}
