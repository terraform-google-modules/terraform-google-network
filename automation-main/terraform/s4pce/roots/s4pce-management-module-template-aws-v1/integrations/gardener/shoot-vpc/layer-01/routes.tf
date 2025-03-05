/*
  Description: Handles adding routes to Gardener managed route tables
  Comments:
*/

### Routes to the Management VPC from the Shoot VPC via VPC Peering
### QUESTION:  Does Management really need access to the Gardener Subnets?
resource "aws_route" "shoot_to_management" {
  for_each                  = local.gardener_managed_route_tables
  route_table_id            = each.value
  destination_cidr_block    = local.layer_00_outputs.vpc_shoot.management_cidr_block
  vpc_peering_connection_id = local.layer_00_outputs.aws_vpc_peering_connection_shoot.id
}
