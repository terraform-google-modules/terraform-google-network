/*
  Description: Core module configurations
  Layer: 00
  Dependencies:
    layer-00: outputs
    layer-02: outputs
*/

##### AWS Account Information
data "aws_caller_identity" "current" {}

locals {
  base_context = data.terraform_remote_state.layer_00.outputs._context
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
      deployment_layer = "dev-management-layer-00"
    }
  }
}
