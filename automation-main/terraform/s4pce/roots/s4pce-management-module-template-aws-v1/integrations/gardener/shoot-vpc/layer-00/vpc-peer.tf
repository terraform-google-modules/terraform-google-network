/*
  Description: Creates the VPC Peer between Shoot and Management VPC
  Comments: N/A
*/

resource "aws_vpc_peering_connection" "shoot" {
  peer_vpc_id = local.layer_00_outputs.vpc_main01.id
  vpc_id      = aws_vpc.shoot.id
  auto_accept = true
  tags = {
    Name        = "${local.layer_00_outputs.vpc_main01.name}/${local.layer_resource_prefix} peer"
    Description = "Gardener Shoot to Management / ${local.base_friendly_name} Shoot VPC Peer"
  }
}

##### Outputs
output "aws_vpc_peering_connection_shoot" { value = {
  id            = aws_vpc_peering_connection.shoot.id
  peer_owner_id = aws_vpc_peering_connection.shoot.peer_owner_id
  peer_vpc_id   = aws_vpc_peering_connection.shoot.peer_vpc_id
  vpc_id        = aws_vpc_peering_connection.shoot.vpc_id
} }
