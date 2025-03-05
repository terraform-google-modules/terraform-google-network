/*
  Description: Terraform input variables
*/

# ### User Variables
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
  type        = string
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
