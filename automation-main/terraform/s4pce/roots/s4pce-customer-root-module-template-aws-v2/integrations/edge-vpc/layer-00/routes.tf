/*
  Description: Handles VPC routing creation
  Layer: 00
  Dependencies:
    layer-00: vpc, subnets, gateways
  Comments: Managed by individual routes, not route table.  If you manage by the route table, this will wholesale wipe out undocumented routes.
    Route Tables:
      main01_default
*/


### Default Route Table
resource "aws_default_route_table" "main01_default" {
  default_route_table_id = aws_vpc.main01.default_route_table_id
  propagating_vgws = [
    aws_vpn_gateway.main01.id,
  ]
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} Default Route"
  })
}
