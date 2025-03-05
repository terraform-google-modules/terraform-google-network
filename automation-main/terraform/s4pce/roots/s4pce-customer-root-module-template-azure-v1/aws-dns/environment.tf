/*
  Description: Environment-specific configurations required for module setup; Declaration of providers, backend settings, and remote state locations
  Comments: The contents of this file should not be modified by Operators
*/

### Providers
provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

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
    #EXAMPLE_BACKEND_key                  = "EXAMPLE0001/aws-dns/terraform.tfstate"
  }
}

### Remote State
locals {
  aws_layer_00   = data.terraform_remote_state.aws_layer_00.outputs
  azure_layer_00 = data.terraform_remote_state.azure_layer_00.outputs
  azure_layer_02 = data.terraform_remote_state.azure_layer_02.outputs
}

# AWS
data "terraform_remote_state" "aws_layer_00" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = var.aws_region
    bucket         = "EXAMPLE_AWS_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/layer-00/${var.aws_region}/terraform.tfstate"
  }
}

# Azure
data "terraform_remote_state" "azure_layer_00" {
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

data "terraform_remote_state" "azure_layer_02" {
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
