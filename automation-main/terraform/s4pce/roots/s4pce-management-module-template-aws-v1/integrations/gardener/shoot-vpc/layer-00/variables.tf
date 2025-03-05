/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/


##### Mandatory Variables
variable "aws_region" {
  description = "AWS region"
}

##### VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC. Gardener will deploy resources here."
  type        = string
}
variable "vpc_secondary_cidr_block" {
  description = "Addtional CIDR block for the VPC.  Used for RDS and Private Link Resources"
  type        = string
}
variable "vpc_secondary_subnets" {
  description = "Subnets for RDS and Private Link Resources, place in secondary CIDR to ensure separate from Gardener"
  type = map(
    object({
      cidr    = string
      zone    = string
      for_rds = optional(bool, false)
  }))
  default = {}
}

variable "vpc_name" {
  description = "Name of the VPC being created"
  type        = string
  default     = "shoot-vpc"
}
variable "vpc_domain_name" {
  description = "VPC Domain name for use in DHCP-Opts"
  type        = string
}
