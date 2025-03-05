/*
  Description: Creates pre-requisite network
  Comments: Uses the generic aws-network module to create a testing network.
*/

locals {
  network = {
    primary = {
      cidr = "172.16.0.0/22"
      subnets = {
        zone_a = { cidr = "172.16.0.0/24", zone = "a" }
        zone_b = { cidr = "172.16.1.0/24", zone = "b" }
    } }
  }

  tags = {}
  # tags = {
  #   # Typical tags applied by null-context
  #   Business                 = "test-business"
  #   Customer                 = "test-customer"
  #   Description              = "Test-Description"
  #   Environment              = "test-env"
  #   GeneratedBy              = "terraform"
  #   ManagedBy                = "terraform"
  #   Name                     = "test-module-directory-service"
  #   Organization             = "test-org"
  #   OrganizationFriendlyName = "Sovereign Cloud STE"
  #   Owner                    = "test-owner"
  #   SecurityBoundary         = "test"
  #   TerraformModule          = "aws-directory-service"
  # }
}


module "network" {
  # source     = "../../aws-network"
  source              = "../../../../ste-automation/terraform/tools/modules/aws-network"
  aws_region          = var.aws_region
  build_user          = var.build_user
  tags                = local.tags
  network             = local.network
  deploy_nat_gateways = false
}

data "aws_iam_policy_document" "test" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "test" {
  name               = "test"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.test.json
}
resource "aws_iam_instance_profile" "test" {
  name = "test"
  role = aws_iam_role.test.name
}
resource "aws_key_pair" "test" {
  key_name   = "test-directory-service-module"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_route53_zone" "test" {
  name = "test.internal"
  vpc {
    vpc_id = module.network.vpc.id
  }
}
