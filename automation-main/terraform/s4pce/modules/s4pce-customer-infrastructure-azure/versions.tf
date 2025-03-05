/*
  Description: Required Terraform Versions
*/

terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.53.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }
  }
}
