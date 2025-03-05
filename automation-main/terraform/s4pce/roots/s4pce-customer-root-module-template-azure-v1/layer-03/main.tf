/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
*/

### Core Data Resources
data "azurerm_subscription" "current" {}

### Context
locals {
  base_context = local.layer_00.base_context
}

module "layer_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = local.base_context

  environment_values = {
    kv = {
      deployment_layer = var.deployment_layer
    }
    tags   = null
    locals = null
  }
}
