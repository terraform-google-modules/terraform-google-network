/*
  Description: Backend settings required for module setup; Declaration of providers, local variables, and backend remote state locations
  Layer: 00
  Comments:
*/

###### Backend
terraform {
  backend "azurerm" {
    #EXAMPLE_BACKEND_environment          = "EXAMPLE_AZURE_ENVIRONMENT"
    #EXAMPLE_BACKEND_subscription_id      = "EXAMPLE_SUBSCRIPTION_ID"
    #EXAMPLE_BACKEND_resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    #EXAMPLE_BACKEND_storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    #EXAMPLE_BACKEND_container_name       = "EXAMPLE_CONTAINER_NAME"
    #EXAMPLE_BACKEND_key                  = "EXAMPLE0001/integrations/sftp/terraform.tfstate"
  }
}

##### Providers
provider "azurerm" {
  environment     = var.azure_environment
  subscription_id = var.azure_subscription_id
  features {}
}

### Remote State
locals {
  layer_00       = data.terraform_remote_state.layer_00.outputs
  layer_02       = data.terraform_remote_state.layer_02.outputs
  layer_edge_net = data.terraform_remote_state.layer_edge_net.outputs
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

data "terraform_remote_state" "layer_edge_net" {
  backend = "azurerm"
  config = {
    environment          = var.azure_environment
    subscription_id      = var.azure_subscription_id
    resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    container_name       = "EXAMPLE_CONTAINER_NAME"
    key                  = "EXAMPLE0001/integrations/edge-network/layer-00/terraform.tfstate"
  }
}

data "terraform_remote_state" "layer_02" {
  backend = "azurerm"
  config = {
    environment          = var.azure_environment
    subscription_id      = var.azure_subscription_id
    resource_group_name  = "EXAMPLE_RESOURCE_GROUP_NAME"
    storage_account_name = "EXAMPLE_STORAGE_ACCOUNT_NAME"
    container_name       = "EXAMPLE_CONTAINER_NAME"
    key                  = "EXAMPLE0001/layer-02/terraform.tfstate"
  }
}
