/*
  Description: Terraform layer-02 input variables
  Layer: 02
  Comments: N/A
*/

##### Mandatory Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}
