/*
  Description: Security groups for the Customer VPC
  Comments: N/A
*/

##### Remove all rules from default security Group
resource "aws_default_security_group" "customer_default_sg" {
  vpc_id = aws_vpc.customer.id

  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-default"
    Managed-By = "terraform"
  }
}

###### Security Groups
### All-Egress
resource "aws_security_group" "customer_all_egress" {
  vpc_id      = aws_vpc.customer.id
  name        = "${aws_vpc.customer.tags.Name}-all-egress"
  description = "Allows outbound traffic for ${aws_vpc.customer.tags.Name} VPC"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows all outbound traffic for ${aws_vpc.customer.tags.Name} VPC subnet"
  }

  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-all-egress"
    Managed-By = "terraform"
  }
}

### Access-VPC
resource "aws_security_group" "customer_vpc" {
  vpc_id      = aws_vpc.customer.id
  name        = "${aws_vpc.customer.tags.Name}-vpc"
  description = "Allows all communication within the ${aws_vpc.customer.tags.Name} VPC"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
    description = "Allows traffic from ${aws_vpc.customer.tags.Name} ingress to all protocols and ports"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr_block]
    description = "Allows traffic to ${aws_vpc.customer.tags.Name} egress to all protocols and ports"
  }
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-vpc"
    Managed-By = "terraform"
  }
}

### Access-Management
resource "aws_security_group" "customer_access_management" {
  vpc_id      = aws_vpc.customer.id
  name        = "${aws_vpc.customer.tags.Name}-management"
  description = "Allows communication between VPCs ${data.aws_vpc.management.tags.Name} and ${aws_vpc.customer.tags.Name}"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [data.aws_vpc.management.cidr_block]
    description = "Allows traffic from ${data.aws_vpc.management.tags.Name} ingress to all protocols and ports"
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["10.200.0.0/16", "10.64.0.0/16"]
    description = "Allows traffic from CRE SMS ingress to all protocols and ports"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [data.aws_vpc.management.cidr_block]
    description = "Allows traffic to ${data.aws_vpc.management.tags.Name} egress to all protocols and ports"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["10.200.0.0/16", "10.64.0.0/16"]
    description = "Allows traffic to CRE SMS egress to all protocols and ports"
  }

  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-management"
    Managed-By = "terraform"
  }
}
