/*
  Description: Handles AWS SSH key pairs
  Layer: 02
  Comments: N/A
*/

resource "aws_key_pair" "main01" {
  key_name   = module.base_layer_context.tags.VPC
  public_key = var.ssh_main01_public_key
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.tags.VPC
    Description = "${module.base_layer_context.customer} key pair"
  })
}
