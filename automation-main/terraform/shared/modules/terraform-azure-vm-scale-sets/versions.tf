/*
  Description: providers/versions
  Comment:
*/
terraform {
  required_version = ">= 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = ">=2.3.4"
    }
    template = {
      source  = "hashicorp/template"
      version = ">=2.2.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}
