/*
  Description: Required Versions
  Comments:
    - N/A
*/

terraform {
  required_version = ">=1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.3.0"
    }
  }
}
