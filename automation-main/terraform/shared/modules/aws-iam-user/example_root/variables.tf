/*
  Description: Terraform input variables; Variables that define the iam users to be created
  Comments:
*/

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

variable "aws_region" {
  description = "AWS region this module will be run in"
}
