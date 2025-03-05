/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

### Core Data Resources
data "azurerm_subscription" "current" {}

### Context
locals {
  base_context = local.layer_00.base_context
}

module "layer_context" {
  source     = "../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context    = local.base_context
  customer   = "${local.base_context.customer}-reverse-link"
  build_user = var.build_user
  environment_values = {
    kv = {
      deployment_layer     = var.deployment_layer
      tag_productcomponent = "proxy-server"
    }
    tags   = null
    locals = null
  }
}
