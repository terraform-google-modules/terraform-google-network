/*
  Description: Create the Internet and Nat Gateways for the Management VPC
  Comments: N/A
*/

##### Create Internet Gateway
resource "aws_internet_gateway" "customer_igw" {
  vpc_id = aws_vpc.customer.id
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-default"
    Managed-By = "terraform"
  }
}

#### Create Nat Gateway
resource "aws_nat_gateway" "customer_ngw1" {
  allocation_id = aws_eip.vpc_ngw1_eip.id
  subnet_id     = aws_subnet.customer_edge_1a.id
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-nat_gateway"
    Managed-By = "terraform"
  }
}
