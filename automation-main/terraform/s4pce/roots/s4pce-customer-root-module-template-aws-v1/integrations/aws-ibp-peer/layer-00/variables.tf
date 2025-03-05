/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### IBP Variables
variable "ibp_customer" {
  description = "IBP Customer to peer with"
  type        = string
}
variable "ibp_profile" {
  description = "Terraform profile for accessing IBP"
  type        = string
}
variable "ibp_bucket" {
  description = "Terraform state bucket for IBP"
  type        = string
  default     = "ibp-production-terraform"
}
