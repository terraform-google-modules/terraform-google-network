/*
  Description: Variables needed to deploy IAM groups and attach policies; Creates groups based on tfvar input
  Comments: N/A
*/

variable "aws_region" {
  description = "Set the AWS region"
}

variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
}


variable "iam_group_object" {
  type = object({
    name        = string
    policy_list = list(string)
  })
}
