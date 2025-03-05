/*
  Description: Variables needed to deploy a single IAM role, attached policies, and optionally create instance profiles from with the created role
  Comments: N/A
*/


variable "build_user" {
  description = "Employee ID that is running the terraform code"
}

variable "iam_role_name" {
  description = "Input variable to module for the name of the created IAM role"
}

variable "iam_role_description" {
  description = "Input variable to module for the description of the created IAM role"
}

variable "assume_role_policy" {
  description = "(JSON) AWS trust policy that allows for the IAM Role Assume a different AWS role"
}

variable "iam_policy_arn_list" {
  description = "List of IAM Policy ARNs to attach to the IAM Role"
  type        = list(string)
}

variable "iam_instance_profile_name" {
  description = "IAM Instance Profiles to create and attach to the IAM Role"
}

variable "tag_managedby" {
  description = "What will manage this resource"
  default     = "UNTAGGED"
}

variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
  default     = ""
}
