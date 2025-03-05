
/*
  Description: Creates the VPC Peer between Customer and Management VPC
  Comments: N/A
*/

resource "aws_vpc_peering_connection" "customer" {
  peer_vpc_id = data.aws_vpc.management.id
  vpc_id      = aws_vpc.customer.id
  auto_accept = true

  tags = {
    Name       = "${data.aws_vpc.management.tags.Name}/${var.vpc_custom_name} peer"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}
