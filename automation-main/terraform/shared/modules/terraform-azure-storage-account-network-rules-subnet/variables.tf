/*
  Description: Terraform input variables
*/

variable "resource_group" {
  description = "Name of the Resource Group that the Storage Account belongs to"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Storage Account to manage subnet network-rules for"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to enforce Store Account network rule for"
  type        = string
}
