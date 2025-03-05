/*
  Description: Core module configurations
  Comments: N/A
*/

##### AWS Account Information
data "aws_caller_identity" "current" {}

locals {
  base_context                 = data.terraform_remote_state.layer_00.outputs._context
  layer_00_outputs             = data.terraform_remote_state.layer_00.outputs
  layer_02_outputs             = data.terraform_remote_state.layer_02.outputs
  integration_layer_00_outputs = data.terraform_remote_state.integration_layer_00.outputs
}

module "base_layer_context" {
  source     = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
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
      vpc              = "${local.base_context.security_boundary}-${local.base_context.business}-${local.base_context.customer}-edge"
      deployment_layer = "edge-vpc-layer-01"
    }
  }
}
