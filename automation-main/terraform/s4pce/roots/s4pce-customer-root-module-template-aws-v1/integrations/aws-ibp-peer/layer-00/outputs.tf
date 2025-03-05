/*
  Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
  Comments: N/A
*/

output "vpc_peer" { value = {
  id            = aws_vpc_peering_connection.main01.id
  vpc_id        = aws_vpc_peering_connection.main01.vpc_id
  peer_owner_id = aws_vpc_peering_connection.main01.peer_owner_id
  peer_vpc_id   = aws_vpc_peering_connection.main01.peer_vpc_id
} }
