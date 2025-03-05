/*
  Description: Handles VPC routing creation
  Comments: N/A
*/

##### Customer Edge Default Route Table
module "context_aws_default_route_table_edge_vpc" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "edge-vpc"
  description = "${module.base_layer_context.resource_prefix} edge VPC default"
}

resource "aws_default_route_table" "edge_vpc_default_route" {
  default_route_table_id = aws_vpc.edge_vpc.default_route_table_id
  tags                   = module.context_aws_default_route_table_edge_vpc.tags
  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      propagating_vgws
    ]
  }
}
