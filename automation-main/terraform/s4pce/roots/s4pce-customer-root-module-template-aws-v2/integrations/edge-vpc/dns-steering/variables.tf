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

variable "dns_account_profile" {
  description = "AWS Profile of the DNS Account"
  type = object({
    name   = string // AWS Profile Name
    region = string // AWS Profile Region
  })
}

variable "dns_steering_zone" {
  description = "DNS Steering Zone information"
  type = object({
    fqdn = string // Top-Level Zone FQDN
    id   = string // Top-Level Zone ID
  })
}
