/*
  Description: Terraform input variables; Variables that should be changes on creation of a new S4PCE Customer VPC
  Comments:
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

