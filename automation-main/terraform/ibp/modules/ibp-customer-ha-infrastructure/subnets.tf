/*
  Description: Creates the Customer VPC subnets; Creates basic subnets.  Subnets in other availabilty zones are commented out.
  Comments: N/A
*/

##### Private Production Subnets
resource "aws_subnet" "customer_production_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_production_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1a-production"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "customer_production_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_production_1b_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1b-production"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

##### Private DataServices Subnets
resource "aws_subnet" "customer_dataservices_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_dataservices_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1a-dataservices"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "customer_dataservices_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_dataservices_1b_cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1b-dataservices"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "customer_dataservices2_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_dataservices2_1a_cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1a-dataservices2"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

##### Private staging Subnets
resource "aws_subnet" "customer_staging_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_staging_1a_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1a-staging"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

##### Edge Subnets
resource "aws_subnet" "customer_edge_1a" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = var.subnet_edge_1a_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1a-edge"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "customer_edge_1b" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}b"
  cidr_block              = var.subnet_edge_1b_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1b-edge"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "customer_edge_1c" {
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}c"
  cidr_block              = var.subnet_edge_1c_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name       = "${aws_vpc.customer.tags.Name}-az1c-edge"
    Managed-By = "terraform"
  }
  lifecycle {
    prevent_destroy = false
  }
}

##### Prepopulated Subnets reserved for other availability zones.

// resource "aws_subnet" "customer_dataservices2_1b" {
//   vpc_id                  = aws_vpc.customer.id
//   availability_zone       = "${var.aws_region}b"
//   cidr_block              = var.subnet_dataservices2_1b_cidr_block
//   map_public_ip_on_launch = "false"
//   tags = {
//     Name       = "${aws_vpc.customer.tags.Name}-az1b-dataservices2"
//     Managed-By = "terraform"
//   }
//   lifecycle {
//     prevent_destroy = false
//   }
// }

# resource "aws_subnet" "customer_staging_1b" {
#   vpc_id            = aws_vpc.customer.id
#   availability_zone = "${ var.aws_region }b"
#   cidr_block        = var.subnet_staging_1b_cidr_block
#   map_public_ip_on_launch = false
#   tags = {
#     Name = "${ aws_vpc.customer.tags.Name }-az1b-staging"
#     Managed-By = "terraform"
#   }
#   lifecycle {
#     prevent_destroy = false
#   }
# }
