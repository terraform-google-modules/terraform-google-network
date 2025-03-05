/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
    - The management_vpc_name should match the existing Management VPC in the account
    - vpc_custom_octet should be a unique CIDR block in the account
    - vpc_custom_name should be a unique CIDR block in the account
    - loadbalancer_listener should be changes to 1 once the ALB Certificate has been generated
    - loadbalancer_certificate_arn should be supplied once the certificate has been generated
*/

##### Module Dependecy
variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
}

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
  default     = "us-gov-west-1"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### Management data
variable "management_vpc_name" {
  description = "AWS vpc name of the management vpc"
  default     = "ibp-management"
}

##### VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the customer VPC"
}
variable "vpc_custom_name" {
  description = "AWS VPC Name for the Customer VPC"
  # default = "ibp-customer0000"
}

##### Subnet Variables
variable "subnet_production_1a_cidr_block" {
  description = "CIDR block for the production 1a subnet"
}
variable "subnet_production_1b_cidr_block" {
  description = "CIDR block for the production 1b subnet"
}
variable "subnet_dataservices_1a_cidr_block" {
  description = "CIDR block for the dataservices 1a subnet"
}
variable "subnet_dataservices_1b_cidr_block" {
  description = "CIDR block for the dataservices 1b subnet"
}
variable "subnet_dataservices2_1a_cidr_block" {
  description = "CIDR block for the dataservices2 1a subnet"
}
variable "subnet_dataservices2_1b_cidr_block" {
  description = "CIDR block for the dataservices2 1b subnet"
}
variable "subnet_staging_1a_cidr_block" {
  description = "CIDR block for the staging 1a subnet"
}
variable "subnet_staging_1b_cidr_block" {
  description = "CIDR block for the subnet 1b subnet"
}
variable "subnet_edge_1a_cidr_block" {
  description = "CIDR block for the edge 1a subnet"
}
variable "subnet_edge_1b_cidr_block" {
  description = "CIDR block for the edge 1b subnet"
}
variable "subnet_edge_1c_cidr_block" {
  description = "CIDR block for the edge 1c subnet"
}
