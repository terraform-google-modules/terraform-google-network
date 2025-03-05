/*
  Description: Declaration of providers, local variables, and backend remote state locations
  Layer: 00
*/

### Providers
provider "azurerm" {
  environment     = var.azure_environment
  subscription_id = var.azure_subscription_id
  features {}
}

### Backend
terraform {
  backend "azurerm" {
    #EXAMPLE_BACKEND_environment          = "EXAMPLE_AZURE_ENVIRONMENT"
    #EXAMPLE_BACKEND_subscription_id      = "EXAMPLE_SUBSCRIPTION_ID"
    #EXAMPLE_BACKEND_resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    #EXAMPLE_BACKEND_storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    #EXAMPLE_BACKEND_container_name       = "EXAMPLE_CONTAINER_NAME"
    #EXAMPLE_BACKEND_key                  = "EXAMPLE0001/integrations/s4-management/layer-00/terraform.tfstate"
  }
}

### Remote State
locals {
  layer_00            = data.terraform_remote_state.layer_00.outputs
  management_layer_00 = data.terraform_remote_state.management_layer_00.outputs
  management_layer_01 = data.terraform_remote_state.management_layer_01.outputs
}

data "terraform_remote_state" "layer_00" {
  backend = "azurerm"
  config = {
    environment          = var.azure_environment
    subscription_id      = var.azure_subscription_id
    resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    container_name       = "EXAMPLE_CONTAINER_NAME"
    key                  = "EXAMPLE0001/layer-00/terraform.tfstate"
  }
}

data "terraform_remote_state" "management_layer_00" {
  backend = "azurerm"
  config = {
    environment          = var.azure_environment
    subscription_id      = var.azure_subscription_id
    resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    container_name       = "EXAMPLE_CONTAINER_NAME"
    key                  = "EXAMPLE_MANAGEMENT_KEY/layer-00/terraform.tfstate"
  }
}

data "terraform_remote_state" "management_layer_01" {
  backend = "azurerm"
  config = {
    environment          = var.azure_environment
    subscription_id      = var.azure_subscription_id
    resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    container_name       = "EXAMPLE_CONTAINER_NAME"
    key                  = "EXAMPLE_MANAGEMENT_KEY/layer-01/terraform.tfstate"
  }
}
