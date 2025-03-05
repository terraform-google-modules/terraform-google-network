/*
  Description: Handles AWS SSH key pairs
  Layer: 02
  Comments: N/A
*/

locals {
  default_keypair_name = try(var.ssh_keypair_name, "${module.base_layer_context.context.security_boundary}-${module.base_layer_context.context.business}-${module.base_layer_context.context.customer}")
}

resource "aws_key_pair" "main01" {
  key_name   = local.default_keypair_name
  public_key = var.ssh_main01_public_key
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.tags.VPC
    Description = "${module.base_layer_context.customer} key pair"
  })
}