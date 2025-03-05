##### AWS Account Information
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Metadata
locals {
  management_layer_00_outputs = data.terraform_remote_state.management_layer_00.outputs
  management_layer_01_outputs = data.terraform_remote_state.management_layer_01.outputs
}

module "base_context" {
  source            = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  account_id        = data.aws_caller_identity.current.account_id
  build_user        = var.build_user
  business          = var.business
  customer          = var.customer
  environment       = var.environment
  organization      = var.organization
  owner             = var.owner
  partition         = data.aws_partition.current.partition
  region            = var.aws_region
  security_boundary = var.security_boundary
  environment_values = {
    tags = [
      {
        name     = "BusinessSubsection"
        value    = "business_subsection"
        required = false
      }
    ]
    locals = null
    kv = {
      organization_friendly_name      = var.organization_friendly_name
      security_boundary_friendly_name = var.security_boundary_friendly_name
      business_friendly_name          = var.business_friendly_name
      business_subsection             = var.business_subsection
      prefix_friendly_name            = "${var.security_boundary_friendly_name} ${var.business_friendly_name} ${var.customer}"
    }
  }
}

module "base_layer_context" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  build_user = var.build_user
  context    = module.base_context.context
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
      vpc              = module.base_context.resource_prefix
      deployment_layer = "layer-00"
    }
  }
}

##### Metadata variables
output "_context" { value = module.base_context.context }
output "_tags" { value = module.base_layer_context.tags }
output "_resource_prefix" { value = module.base_context.resource_prefix }
output "_friendly_name" { value = module.base_context.environment_values.kv.prefix_friendly_name }
