/*
  Description: Create IAM users, Attach policies, and add group membership
  Comments:
*/

##### Get AWS Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Base Context
module "base_context" {
  source            = "../../../../../shared/modules/terraform-null-context/modules/legacy"
  account_id        = data.aws_caller_identity.current.account_id
  build_user        = var.build_user
  business          = "test"
  customer          = "test"
  environment       = "test"
  organization      = "test"
  owner             = "test"
  partition         = data.aws_partition.current.partition
  name              = "terraform-aws-pce-customer-interface"
  region            = var.aws_region
  security_boundary = "test"
  environment_values = {
    tags   = null
    locals = null
    kv     = {}
  }
}

##### Prepare test environment
### Create VPCs
resource "aws_vpc" "test_service_vpc" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"
  tags             = module.base_context.tags
}

### Create Subnets
resource "aws_subnet" "test_service_vpc" {
  vpc_id                  = aws_vpc.test_service_vpc.id
  availability_zone       = "us-gov-west-1a"
  cidr_block              = aws_vpc.test_service_vpc.cidr_block
  map_public_ip_on_launch = "false"
  tags                    = module.base_context.tags
}


#### Internet Gateway
resource "aws_internet_gateway" "test_service_vpc" {
  vpc_id = aws_vpc.test_service_vpc.id
  tags   = module.base_context.tags
}

### Routes
resource "aws_default_route_table" "test_service_vpc" {
  default_route_table_id = aws_vpc.test_service_vpc.default_route_table_id
  tags                   = module.base_context.tags
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
      aws_vpc.test_service_vpc.cidr_block
    ]
    description = "Allows ingress for ${aws_vpc.test_service_vpc.tags.Name} from internal and NS2"
  }
  tags = module.base_context.tags
}

### Create Destination EFS
resource "aws_efs_file_system" "test_service_vpc" {
  encrypted = true
  tags      = module.base_context.tags
}
resource "aws_efs_mount_target" "test_service_vpc" {
  file_system_id = aws_efs_file_system.test_service_vpc.id
  subnet_id      = aws_subnet.test_service_vpc.id
  security_groups = [
    aws_default_security_group.test_service_vpc.id
  ]
}

##### End of environment setup
