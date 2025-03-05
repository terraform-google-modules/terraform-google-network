/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
    - The management_vpc_name should match the existing Management VPC in the account
    - vpc_custom_octet should be a unique CIDR block in the account
    - vpc_prefix should be a unique CIDR block in the account
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### VPC Variables
variable "edge_vpc_cidr" {
  description = "Edge VPC CIDR block"
}

##### Subnet Variables
variable "edge_vpc_1a_cidr" {
  description = "Edge VPC subnet for subnet 1a"
}
variable "edge_vpc_1a_az" {
  description = "Zone for subnet 1a"
  type        = string
}
variable "edge_vpc_1b_cidr" {
  description = "Edge VPC subnet for subnet 1b"
}
variable "edge_vpc_1b_az" {
  description = "Zone for subnet 1a"
  type        = string
}
variable "edge_vpc_ingress_cidr_list" {
  description = "Edge VPC ingress CIDR list"
}


variable "endpoint_nlb_subnets" {
  description = "Subnet (key) where to create nlb for endpoint services. Key matches subnet created in layer-00. Restrict one subnet (key) per zone."
  type        = list(string)
  default     = ["dataservices_1", "dataservices_2"]
}
