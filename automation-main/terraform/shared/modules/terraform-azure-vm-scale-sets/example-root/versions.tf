/*
  Description: provider/version
  Comment:
*/
terraform {
  required_version = ">= 1.0.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.1"
    }
    local = {
      source = "hashicorp/local"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}
