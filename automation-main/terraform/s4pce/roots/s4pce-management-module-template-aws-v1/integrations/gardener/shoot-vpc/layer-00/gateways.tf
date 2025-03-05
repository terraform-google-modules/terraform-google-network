/*
  Description: Handles creation of Internet and Nat Gateways; Creates gateways and associated EIPs if necessary
  Comments:
*/

##### Shoot Internet Gateway
resource "aws_internet_gateway" "shoot_igw" { # NOTE: Gardener also requires that an internet gateway is attached to the VPC
  vpc_id = aws_vpc.shoot.id
}
