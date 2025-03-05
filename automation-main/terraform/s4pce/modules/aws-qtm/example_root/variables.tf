/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

# variable "egress_to_instances" {
#   description = "List of instances QTM allowed to connect to"
#   type        = list(string)
#   default     = []
# }


# variable "certificate_arn" {
#   description = "ARN of the Certificate to use."
#   type        = string
#   validation {
#     condition     = can(regex("arn:.*:acm:.*:.*:certificate/.*", var.certificate_arn))
#     error_message = "Certificate ARN must be of syntax arn:___PARTITION___:acm:___REGION___:___ACCOUNT___:certificate/___CERTIFICATE_ID___"
#   }
# }
