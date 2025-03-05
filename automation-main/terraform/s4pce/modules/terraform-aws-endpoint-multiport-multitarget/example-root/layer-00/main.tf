/*
  Description: Creates the base testing Infrastructure
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
  region            = var.aws_region
  security_boundary = "test"
  environment_values = {
    tags   = null
    locals = null
    kv     = {}
  }
}

##### Prepare test environment
### Create Service Network
locals {
  service_network = {
    primary = {
      cidr = "192.168.1.0/24"
      subnets_edge = {
        edge_a = { cidr = "192.168.1.0/24", zone = "a" }
    } }
  }
  tags_service_network = {
    Name        = "test_service_network"
    Description = "terraform-aws-endpoint-multiport-multitarget testing"
  }
}
module "service_network" {
  source              = "../../../../../tools/modules/aws-network"
  aws_region          = var.aws_region
  build_user          = var.build_user
  tags                = local.tags_service_network
  network             = local.service_network
  deploy_nat_gateways = false
}

### Create Consumer Network
locals {
  consumer_network = {
    primary = {
      cidr = "192.168.2.0/24"
      subnets_edge = {
        edge_a = { cidr = "192.168.2.0/24", zone = "a" }
    } }
  }
  tags_consumer_network = {
    Name        = "test_consumer_network"
    Description = "terraform-aws-endpoint-multiport-multitarget testing"
  }
}
module "consumer_network" {
  source              = "../../../../../tools/modules/aws-network"
  aws_region          = var.aws_region
  build_user          = var.build_user
  tags                = local.tags_consumer_network
  network             = local.consumer_network
  deploy_nat_gateways = false
}

### Keypair
resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = local.tags_service_network.Name
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
resource "aws_instance" "instance1" {
  ami           = data.aws_ami.instance.image_id
  instance_type = "t3a.micro"
  key_name      = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [
    module.service_network.security_groups["base_egress"].id,
    module.service_network.security_groups["base_ingress"].id,
  ]
  subnet_id                   = module.service_network.subnets["192.168.1.0/24"].id
  associate_public_ip_address = true
  tags                        = local.tags_service_network
  lifecycle {
    ignore_changes  = [ami, tags, ebs_optimized]
    prevent_destroy = false
  }
}

resource "aws_instance" "instance2" {
  ami           = data.aws_ami.instance.image_id
  instance_type = "t3a.micro"
  key_name      = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [
    module.service_network.security_groups["base_egress"].id,
    module.service_network.security_groups["base_ingress"].id,
  ]
  subnet_id                   = module.service_network.subnets["192.168.1.0/24"].id
  associate_public_ip_address = true
  tags                        = local.tags_service_network
  lifecycle {
    ignore_changes  = [ami, tags, ebs_optimized]
    prevent_destroy = false
  }
}
##### End of environment setup
