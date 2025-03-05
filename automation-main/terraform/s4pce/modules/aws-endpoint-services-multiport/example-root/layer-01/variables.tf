/*
  Description: Variables for the terraform-aws-pce-customer-interface modules
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### Testing Variables
variable "bucket" {
  description = "Bucket holding the state file of the network (layer-00)"
  type        = string
}
variable "key" {
  description = "Path to the state file of the network (layer-00)"
  type        = string
}
