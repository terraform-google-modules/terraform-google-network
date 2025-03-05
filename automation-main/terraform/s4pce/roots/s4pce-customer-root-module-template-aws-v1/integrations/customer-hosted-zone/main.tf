/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  base_context = data.terraform_remote_state.layer_00.outputs._context
}

module "base_layer_context" {
  source     = "../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  build_user = var.build_user
  context    = local.base_context
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
      vpc                  = "${local.base_context.security_boundary}-${local.base_context.business}-${local.base_context.customer}"
      deployment_layer     = "customer-hosted-zone"
      prefix_friendly_name = local.base_context.environment_values.kv.prefix_friendly_name
    }
  }
}
