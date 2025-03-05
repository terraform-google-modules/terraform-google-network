/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Metadata
locals {
  base_context     = data.terraform_remote_state.layer_00.outputs._context
  layer_00_outputs = data.terraform_remote_state.layer_00.outputs
}

module "base_layer_context" {
  source     = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  build_user = var.build_user
  context    = local.base_context
  custom_values = {
    locals = null
    tags = [
      {
        name     = "VPC"
        value    = "vpc"
        required = true
      }
    ]
    kv = {
      vpc              = "${local.base_context.security_boundary}-${local.base_context.business}-${local.base_context.customer}"
      deployment_layer = "bucket-replication-layer-00"
    }
  }
}
