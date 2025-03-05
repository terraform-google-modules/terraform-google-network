/*
  Description: Required Versions
  Comments:
    - validated with terraform 1.5.7
    - validated with azurerm 4.3.0
*/

terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
