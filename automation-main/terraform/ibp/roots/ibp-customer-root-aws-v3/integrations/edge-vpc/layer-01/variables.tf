/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
    - The management_vpc_name should match the existing Management VPC in the account
    - vpc_custom_octet should be a unique CIDR block in the account
    - vpc_prefix should be a unique CIDR block in the account
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}
