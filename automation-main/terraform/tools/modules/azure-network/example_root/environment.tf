/*
  Description: Environment-specific configurations required for module setup; Declaration of providers, backend settings, and remote state locations
  Comments:
*/

###### Backend
terraform {
  backend "azurerm" {
    # The remainder of the configurations are read in from backend.tfvars
    # For more detailed instructions on how to properly configure the backend, please refer to the README.md documentation.
  }
}

### Providers
provider "azurerm" {
  resource_provider_registrations = "none"
  environment                     = var.azure_environment
  subscription_id                 = var.azure_subscription_id
  features {}
}

provider "azuread" {
  environment = var.azure_environment
}
