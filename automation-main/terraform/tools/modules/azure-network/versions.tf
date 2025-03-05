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
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.1"
    }
  }
}
