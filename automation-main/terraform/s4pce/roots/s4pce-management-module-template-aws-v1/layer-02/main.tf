/*
  Description: Metadata generation
  Comments:
*/

data "aws_caller_identity" "current" {}

locals {
  base_context     = data.terraform_remote_state.layer_00.outputs._context
  layer_00_outputs = data.terraform_remote_state.layer_00.outputs
  layer_01_outputs = data.terraform_remote_state.layer_01.outputs
}

module "base_layer_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context = local.base_context
  custom_values = {
    locals = null
    tags = [
      {
        name     = "VPC"
        value    = "vpc"
        required = true
      },
      {
        name     = "BusinessSubsection"
        value    = "business_subsection"
        required = false
      }
    ]
    kv = {
      vpc                 = local.layer_00_outputs.vpc_main01.name
      deployment_layer    = "layer-02"
      business_subsection = local.base_context.environment_values.kv.business_subsection
    }
  }
}
