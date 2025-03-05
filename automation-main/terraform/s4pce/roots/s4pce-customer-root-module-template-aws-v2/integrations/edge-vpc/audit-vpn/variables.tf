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

variable "ssh_auditor_key" {
  description = "SSH public key to create an AWS EC2 Key from and associate with auditor instances"
}
variable "ami_owner_default" {
  description = "Default AMI Owner to use"
  default     = "156506675147"
}
variable "image_openvpn_name" {
  description = "Search string for OpenVPN image"
  type        = string
}
