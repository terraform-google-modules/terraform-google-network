/*
  Description: Creates the base testing Infrastructure
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

resource "aws_s3_bucket" "test" {
  bucket = "test-s4pce-customer-iam"
}
