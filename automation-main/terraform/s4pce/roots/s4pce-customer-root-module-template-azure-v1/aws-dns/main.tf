/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
*/

##### Core Data Resources
# AWS
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

# Azure
data "azurerm_subscription" "current" {}


### Context
locals {
  aws_base_context   = local.aws_layer_00._context
  azure_base_context = local.azure_layer_00.base_context
}

module "aws_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = local.aws_base_context

  root_module = var.root_module
}

module "azure_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = local.azure_base_context

  root_module = var.root_module
}
