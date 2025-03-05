/*
  Description: Testing Prerequisites
  Comments:
*/

##### Get AWS Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Base Context
module "base_context" {
  source            = "../../../../shared/modules/terraform-null-context/modules/legacy"
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
    tags = [{
      name     = "VPC"
      value    = "vpc"
      required = true
    }]
    locals = null
    kv = {
      prefix_friendly_name = "test"
      vpc                  = "test"
    }
  }
}

resource "aws_iam_role" "test" {
  name        = "test-role"
  description = "test description"
  path        = "/service-role/"
  tags = {
    Name        = "test-role"
    Description = "test description"
  }
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowBackupToAssumeRole",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "backup.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })
}

locals {
  arn_list = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores",
  ]
}
resource "aws_iam_role_policy_attachment" "test" {
  count      = length(local.arn_list)
  role       = aws_iam_role.test.name
  policy_arn = local.arn_list[count.index]
}

resource "aws_vpc" "test" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "test_management"
  }
}
resource "aws_default_route_table" "test" {
  default_route_table_id = aws_vpc.test.default_route_table_id
  propagating_vgws       = []
  tags = {
    Name = "test_management-default"
  }
  lifecycle { ignore_changes = [propagating_vgws] }
}
resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "test_management-nat"
  }
}
