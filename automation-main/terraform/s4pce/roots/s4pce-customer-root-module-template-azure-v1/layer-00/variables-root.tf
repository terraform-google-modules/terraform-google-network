/*
  Description: Standardized Root Terraform Module input variables
  Comments: The contents of this file should not be modified by Operators
*/

### User Variables
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
  type        = string
}

### Terraform Module Variables
variable "root_module" {
  description = "Name of Terraform root module responsible for provisioning resources"
  type        = string
}
variable "deployment_layer" {
  description = "(Optional) Layer of Terraform module deployment"
  type        = string
  default     = null
}

### Azure Variables
variable "azure_environment" {
  description = "Azure Cloud Environment (e.g. usgovernment, public)"
  type        = string
}
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "azure_region" {
  description = "Azure Region"
  type        = string
}
