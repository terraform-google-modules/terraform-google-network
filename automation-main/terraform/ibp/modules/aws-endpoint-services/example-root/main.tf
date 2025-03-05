/*
  Description: Create IAM users, Attach policies, and add group membership
  Comments:
*/

##### Get AWS Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Prepare test environment
### Create VPCs
resource "aws_vpc" "test_service_vpc" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"

  tags = {
    Name         = "test_service_vpc"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

resource "aws_vpc" "test_consumer_vpc" {
  cidr_block       = "192.168.2.0/24"
  instance_tenancy = "default"

  tags = {
    Name         = "test_consumer_vpc"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

### Create Subnets
resource "aws_subnet" "test_service_vpc" {
  vpc_id                  = aws_vpc.test_service_vpc.id
  availability_zone       = "us-gov-west-1a"
  cidr_block              = aws_vpc.test_service_vpc.cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name         = "test_service_vpc subnet"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

resource "aws_subnet" "test_consumer_vpc" {
  vpc_id                  = aws_vpc.test_consumer_vpc.id
  availability_zone       = "us-gov-west-1a"
  cidr_block              = aws_vpc.test_consumer_vpc.cidr_block
  map_public_ip_on_launch = "false"
  tags = {
    Name         = "test_consumer_vpc subnet"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

#### Internet Gateway
resource "aws_internet_gateway" "test_service_vpc" {
  vpc_id = aws_vpc.test_service_vpc.id
  tags = {
    Name         = "test_service_vpc subnet"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

### Routes
resource "aws_default_route_table" "test_service_vpc" {
  default_route_table_id = aws_vpc.test_service_vpc.default_route_table_id
  tags = {
    Name         = "test_service_vpc-default"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
    Managed-By   = "terraform"
  }
  lifecycle {
    ignore_changes = [
      tags,
      propagating_vgws
    ]
  }
}
resource "aws_route" "test_service_vpc_igw" {
  route_table_id         = aws_vpc.test_service_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_service_vpc.id
}

resource "aws_default_route_table" "test_consumer_vpc" {
  default_route_table_id = aws_vpc.test_consumer_vpc.default_route_table_id
  tags = {
    Name         = "test_consumer_vpc-default"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
    Managed-By   = "terraform"
  }
  lifecycle {
    ignore_changes = [
      tags,
      propagating_vgws
    ]
  }
}

### Security Groups
resource "aws_default_security_group" "test_service_vpc" {
  vpc_id = aws_vpc.test_service_vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows egress for ${aws_vpc.test_service_vpc.tags.Name}"
  }
  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      aws_vpc.test_service_vpc.cidr_block,
      "4.35.15.246/32"
    ]
    description = "Allows ingress for ${aws_vpc.test_service_vpc.tags.Name} from internal and NS2"
  }
  tags = {
    Name         = "test_service_vpc-default"
    Managed-By   = "terraform"
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
}

resource "aws_default_security_group" "test_consumer_vpc" {
  vpc_id = aws_vpc.test_consumer_vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows egress for ${aws_vpc.test_consumer_vpc.tags.Name}"
  }
  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      aws_vpc.test_consumer_vpc.cidr_block,
      "4.35.15.246/32"
    ]
    description = "Allows ingress for ${aws_vpc.test_consumer_vpc.tags.Name} from internal and NS2"
  }
  tags = {
    Name         = "test_consumer_vpc-default"
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
  key_name   = aws_vpc.test_service_vpc.tags.Name
  public_key = tls_private_key.keygen.public_key_openssh
}

### Create Service Instance
data "aws_ami" "instance" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Golden-SCS-RHEL-9.2-Base-V*"]
  }
  owners = ["156506675147"]
}

### Create Instance based on found AMI
resource "aws_instance" "instance" {
  ami                         = data.aws_ami.instance.image_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_default_security_group.test_service_vpc.id]
  subnet_id                   = aws_subnet.test_service_vpc.id
  associate_public_ip_address = true
  tags = {
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    BuildUser     = var.build_user
    Name          = "test_service_vpc - endpoint instance"
    Business      = "testing"
    Customer      = "testing"
    Description   = "instance for aws_endpoint_service testing"
    Environment   = "testing"
    Platform      = "testing"
    ProductName   = "testing"
    ProvisionDate = timestamp()
    TerraformName = "test_service_vpc - endpoint instance"
    Account       = data.aws_caller_identity.current.account_id
    Image         = data.aws_ami.instance.name
  }
  lifecycle {
    ignore_changes  = [ami, tags, ebs_optimized]
    prevent_destroy = false
  }
}
##### End of environment setup
