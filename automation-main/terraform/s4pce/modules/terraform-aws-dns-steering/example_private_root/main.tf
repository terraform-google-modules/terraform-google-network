/*
  Description: Create basic requirements for testing.
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
  business          = "test-business"
  customer          = "test-customer"
  environment       = "test-env"
  organization      = "test-org"
  owner             = "test-owner"
  partition         = data.aws_partition.current.partition
  region            = var.aws_region
  security_boundary = "test"
  environment_values = {
    tags   = null
    locals = null
    kv     = {}
  }
}

resource "aws_vpc" "testvpc" {
  cidr_block = "10.0.0.0/24"
  tags       = module.base_context.tags
}

resource "aws_route53_zone" "toplevelzone" {
  name = "dns-steering.test."

  vpc {
    // TODO: make VPC optional to support public domains
    vpc_id = aws_vpc.testvpc.id
  }

  tags = module.base_context.tags
}
