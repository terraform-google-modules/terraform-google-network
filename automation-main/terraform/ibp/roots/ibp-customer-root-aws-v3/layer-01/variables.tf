/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}
variable "efs_subnets" {
  description = "Subnet (key) where to create EFS mount targets. Key matches subnet created in layer-00. Restrict one mount target per zone."
  type        = list(string)
  default     = ["dataservices_1", "dataservices_2"]
}
