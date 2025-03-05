/*
  Description: Terraform main file; Spin up test environment to demonstrate usage of the aws-instance module
  Comments: N/A
*/

################################
# Begin test environment setup #
################################

##### Get AWS Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

### Base Context
module "base_context" {
  source            = "../../../modules/terraform-null-context/modules/legacy"
  account_id        = data.aws_caller_identity.current.account_id
  build_user        = var.build_user
  business          = "test"
  customer          = "test"
  environment       = "test"
  organization      = "test"
  owner             = var.build_user
  partition         = data.aws_partition.current.partition
  region            = var.aws_region
  security_boundary = "test"
  environment_values = {
    tags   = null
    locals = null
    kv     = {}
  }
}

### Create VPCs
resource "aws_vpc" "test_vpc" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"

  tags = {
    Name         = "test-${var.build_user}"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

### Create Subnets
resource "aws_subnet" "test_vpc" {
  vpc_id                  = aws_vpc.test_vpc.id
  availability_zone       = "${var.aws_region}a"
  cidr_block              = aws_vpc.test_vpc.cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name         = aws_vpc.test_vpc.tags.Name
    Managed-by   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

#### Internet Gateway
resource "aws_internet_gateway" "test_vpc" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name         = aws_vpc.test_vpc.tags.Name
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

### Routes
resource "aws_default_route_table" "test_vpc" {
  default_route_table_id = aws_vpc.test_vpc.default_route_table_id
  tags = {
    Name         = "${aws_vpc.test_vpc.tags.Name} default"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes = [
      tags,
      propagating_vgws
    ]
  }
}
resource "aws_route" "test_vpc_igw" {
  route_table_id         = aws_vpc.test_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_vpc.id
}

### Security Groups
resource "aws_default_security_group" "test_vpc" {
  vpc_id = aws_vpc.test_vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows egress for ${aws_vpc.test_vpc.tags.Name}"
  }
  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      aws_vpc.test_vpc.cidr_block,
      "4.35.15.246/32"
    ]
    description = "Allows ingress for ${aws_vpc.test_vpc.tags.Name} from internal and NS2"
  }
  tags = {
    Name         = "${aws_vpc.test_vpc.tags.Name} default"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

### Keypair
resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = aws_vpc.test_vpc.tags.Name
  public_key = tls_private_key.keygen.public_key_openssh
}

### IAM Role
# Create IAM Role
resource "aws_iam_role" "iam_role" {
  name        = aws_vpc.test_vpc.tags.Name
  description = "test role for aws-instance"
  tags = {
    Name         = "${aws_vpc.test_vpc.tags.Name} test"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes = [tags]
  }
  assume_role_policy = file("${path.module}/../../templates/iam/trust/ec2-role-trust-policy.json")
}

# Create IAM instance profile and map IAM Role to all IAM instance profile names passed to module
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = aws_vpc.test_vpc.tags.Name
  role = aws_iam_role.iam_role.name
}

# Create a test placement group
resource "aws_placement_group" "test_vpc" {
  name     = aws_vpc.test_vpc.tags.Name
  strategy = "cluster"
}

##############################
# End test environment setup #
##############################
