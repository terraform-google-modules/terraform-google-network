/*
  Description: Terraform input variables; Variables that should be changed that will be passed to the template module
  Comments:
    - Values should not be specified here.
    - Make appropriate changes in the tfvars file
    - Make additional changes in the main.tf as necessary
*/



variable "aws_region" {
  description = "AWS Region"
}

variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

variable "git_name" {
  description = "Git username to download repositories; define if performing bootstrap through userdata."
}

variable "git_token" {
  description = "Git token to download repositories; define if performing bootstrap through userdata."
}
