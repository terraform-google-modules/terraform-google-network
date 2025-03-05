/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
    - The management_vpc_name should match the existing Management VPC in the account
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the customer VPC"
  default     = ""
}
variable "customer" {
  description = "Short name for the customer"
}

##### Route Table Variables
variable "management_nat_name" {
  description = "AWS managment NAT route table name"
}


##### Legacy Subnet Variables
variable "subnet_production_1a_cidr_block" {
  description = "CIDR block for the production 1a subnet"
  type        = string
  default     = ""
}
variable "subnet_production_1b_cidr_block" {
  description = "CIDR block for the production 1b subnet"
  type        = string
  default     = ""
}
variable "subnet_dataservices_1a_cidr_block" {
  description = "CIDR block for the dataservices 1a subnet"
  type        = string
  default     = ""
}
variable "subnet_dataservices_1b_cidr_block" {
  description = "CIDR block for the dataservices 1b subnet"
  type        = string
  default     = ""
}
variable "subnet_staging_1a_cidr_block" {
  description = "CIDR block for the staging 1a subnet"
  type        = string
  default     = ""
}
# Does not appear to be used? If you want this, use the new network format.
# variable "subnet_staging_1b_cidr_block" {
#   description = "CIDR block for the subnet 1b subnet"
#   type = string
#   default = ""
# }
variable "subnet_edge_1a_cidr_block" {
  description = "CIDR block for the edge 1a subnet"
  type        = string
  default     = ""
}
variable "subnet_edge_1b_cidr_block" {
  description = "CIDR block for the edge 1b subnet"
  type        = string
  default     = ""
}
variable "subnet_edge_1c_cidr_block" {
  description = "CIDR block for the edge 1c subnet"
  type        = string
  default     = ""
}

variable "network" {
  description = "New Network Variable format"
  type = object({
    use_new_network_model = bool
    primary = object({
      cidr = string
      subnets = map(object({
        zone = string
        cidr = string
      }))
      subnets_edge = map(object({
        zone = string
        cidr = string
      }))
    })
  })
  default = {
    use_new_network_model = false
    primary = {
      cidr         = ""
      subnets      = {}
      subnets_edge = {}
    }
  }
}


##### Default Tagging Variables
variable "business" {
  description = "Line of business which the resource is related to e.g., labs, build, ibp, scp, sac, hcm"
}
variable "owner" {
  description = "Owner of the account"
}
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
variable "business_friendly_name" {
  description = "Human readable friendly name of the line of business resources are being deployed for"
  type        = string
}
variable "environment" {
  description = "Environment classification being deployed into; e.g. `development`, `production`"
  type        = string
}


variable "adv_backup_vault_force_destroy" {
  description = "Force destroy recovery points to delete the backup vault"
  default     = false
  type        = bool
}
