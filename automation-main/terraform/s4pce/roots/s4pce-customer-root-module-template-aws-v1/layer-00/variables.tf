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

##### Default Tagging Variables
variable "organization" {
  description = "Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization"
  type        = string
}
variable "organization_friendly_name" {
  description = "Human readable friendly name of the organization this work belongs to"
  type        = string
}
variable "security_boundary" {
  description = "Name of the security boundary being deployed into; will be used as part of naming prefix for all resources"
  type        = string
}
variable "security_boundary_friendly_name" {
  description = "Human readable friendly name of the security boundary being deployed into"
  type        = string
}
variable "business" {
  description = "Line of business which the resource is related to e.g., labs, build, ibp, scp, sac, hcm"
}
variable "business_subsection" {
  description = "Name of the line of business subsection"
  type        = string
}
variable "business_friendly_name" {
  description = "Human readable friendly name of the line of business resources are being deployed for"
  type        = string
}
variable "owner" {
  description = "Owner of the account"
}
variable "environment" {
  description = "Environment classification being deployed into; e.g. `development`, `production`"
  type        = string
}
variable "customer" {
  description = "Customer that uses the deployed system; e.g. `scs`, `management`, `customer00006`"
  type        = string
}


##### Networking Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the customer VPC"
}
variable "subnet_production_1a_cidr_block" {
  description = "CIDR block for the production 1a subnet"
}
variable "subnet_production_1b_cidr_block" {
  description = "CIDR block for the production 1b subnet"
}
variable "subnet_production_1c_cidr_block" {
  description = "CIDR block for the production 1c subnet"
}
variable "subnet_quality_assurance_1a_cidr_block" {
  description = "CIDR block for the quality-assurance 1a subnet"
}
variable "subnet_quality_assurance_1b_cidr_block" {
  description = "CIDR block for the quality-assurance 1b subnet"
}
variable "subnet_quality_assurance_1c_cidr_block" {
  description = "CIDR block for the quality-assurance 1c subnet"
}
variable "subnet_development_1a_cidr_block" {
  description = "CIDR block for the development 1a subnet"
}
variable "subnet_development_1b_cidr_block" {
  description = "CIDR block for the development 1b subnet"
}
variable "subnet_development_1c_cidr_block" {
  description = "CIDR block for the development 1c subnet"
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

##### Additional Endpoints Toggle
variable "additional_endpoints_creation" {
  description = "Additional endpoints state"
  type        = bool
  default     = false
}

##### Additional Endpoints List
variable "additional_endpoints" {
  description = "Additional endpoints"
  type        = list(string)
  default     = []
}
