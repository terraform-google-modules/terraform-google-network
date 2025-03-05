/*
  Description: Handles VPC gateways
  Layer: 00
  Dependencies:
    layer-00: vpc
  Comments:
*/

resource "aws_internet_gateway" "main01" {
  vpc_id = local.edge_vpc_layer_00_outputs.vpc_main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default"
  })
}
