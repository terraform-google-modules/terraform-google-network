/*
  Description: Create testing environment
  Comments:
*/

##### Get AWS Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

### Base Context
module "base_context" {
  source            = "../../../modules/terraform-null-context/modules/legacy"
  account_id        = data.aws_caller_identity.current.account_id
  build_user        = var.build_user
  business          = "test-business"
  customer          = "test-customer"
  environment       = "test-environment"
  organization      = "test-organization"
  owner             = var.build_user
  partition         = data.aws_partition.current.partition
  region            = var.aws_region
  security_boundary = "test-boundary"
  environment_values = {
    tags   = null
    locals = null
    kv = {
      organization_friendly_name      = "Test Organization"
      security_boundary_friendly_name = "Test Boundary"
      business_friendly_name          = "Test Business"
      prefix_friendly_name            = "Test Friendly Name"
    }
  }
}
