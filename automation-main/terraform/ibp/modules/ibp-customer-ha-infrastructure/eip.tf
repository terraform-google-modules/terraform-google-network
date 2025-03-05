/*
  Description: Creates the Elastic IPs for the Management VPC
  Comments: N/A
*/

### External IP for the Nat Gateway
resource "aws_eip" "vpc_ngw1_eip" {
  vpc = true
  tags = {
    Name        = "${aws_vpc.customer.tags.Name}-nat_gateway-eip"
    Managed-By  = "terraform"
    Description = "${aws_vpc.customer.tags.Name} NAT Gateway External IP"
  }
  depends_on = [aws_internet_gateway.customer_igw]
}
