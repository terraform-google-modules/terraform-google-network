/*
  Description: Variables for the IAM role modules
  Comments: N/A
*/

variable "aws_region" {
  description = "AWS Region where the module is run"
}
variable "build_user" {
  description = "Employee ID that is running the terraform code"
}
