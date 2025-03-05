/*
  Description: Variables for the aws-endpoint-services modules
  Comments: N/A
*/

variable "aws_region" {
  description = "AWS Region where the module is run"
}
variable "build_user" {
  description = "Employee ID that is running the terraform code"
}
variable "principal_arns" {
  description = "ARNs of the principals to allow"
  type        = list(string)
  default     = [""]
}
