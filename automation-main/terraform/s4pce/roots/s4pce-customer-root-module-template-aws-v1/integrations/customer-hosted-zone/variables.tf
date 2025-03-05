/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

variable "customer_hosted_zones" {
  type        = list(string)
  description = "Private Hosted Zone of the Customer"
}
variable "customer_dns_map" {
  description = "Map of customer records to add to private hosted zone."
  type = map(
    object({
      type = string,
      data = list(string),
      zone = string
  }))
}
