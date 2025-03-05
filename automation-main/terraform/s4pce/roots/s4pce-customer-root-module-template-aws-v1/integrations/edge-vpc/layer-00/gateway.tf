/*
  Description: Handles VPC gateways
  Layer: 00
  Dependencies:
    layer-00: vpc
  Comments:
*/

resource "aws_vpn_gateway" "main01" {
  vpc_id          = aws_vpc.main01.id
  amazon_side_asn = var.vgw_asn
  tags = merge(module.base_layer_context.tags, {
    Name        = module.base_layer_context.resource_prefix
    Description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} VPC"
  })
}
