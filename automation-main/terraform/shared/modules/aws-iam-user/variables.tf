/*
  Description: Variables needed to deploy a single IAM user and attached policies
  Comments: N/A
*/


variable "aws_region" {
  description = "AWS region this module will be run in"
}

variable "aws-iam-user-object" {
  type = object({
    name        = string
    group_list  = list(string)
    policy_list = list(string)
    tag_company = string
  })
}

variable "build_user" {
  description = "Employee ID that is running the terraform code"
}

variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
}
