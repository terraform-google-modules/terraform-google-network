/*
  Description: Metadata
  Comments: N/A
*/

##### AWS Account Information
data "aws_caller_identity" "current" {}

locals {
  base_context    = data.terraform_remote_state.layer_00.outputs._context
  region          = local.layer_00_outputs._context.region
  resource_prefix = local.layer_00_outputs._resource_prefix
  friendly_name   = local.layer_00_outputs._friendly_name
  customer        = local.layer_00_outputs._context.customer
  partition       = local.layer_00_outputs._context.partition
  account_id      = local.layer_00_outputs._context.account_id
  tags = merge(local.layer_00_outputs._tags, {
    "TerraformDeploymentLayer" = "layer-options"
  })
}
