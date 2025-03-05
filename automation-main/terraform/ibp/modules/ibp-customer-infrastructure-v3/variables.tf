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
  default     = ""
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
variable "management_nat_name" {
  description = "AWS managment NAT route table name"
  default     = "nat"
}
variable "management_backup_service_arn" {
  description = "AWS Backup Service Role Arn"
}

##### VPC Variables
variable "vpc_custom_name" {
  description = "AWS VPC Name for the Customer VPC"
  # default = "ibp-customer0000"
}
variable "vpc_dhcp_options_id" {
  description = "Custom dhcpoptions id to use. Defaults to Management VPCs dhcpoptions otherwise"
  default     = ""
}
variable "customer" {
  description = "Customer Tag value"
}

variable "network" {
  description = "New Network Variable format."
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
}


#### S3 Bucket Variable
variable "backup_versioning" {
  description = "Whether versioning is enabled for s3 bucket"
  type        = string
  default     = "Enabled"
}
#### S3 Binaries Bucket Variable
variable "binaries_versioning" {
  description = "Whether versioning is enabled for s3 binaries bucket"
  type        = string
  default     = "Enabled"
}
#### Disabling/Enabling Backup Plan Variable
variable "enable_backup" {
  type    = number
  default = 1 # Set to 0 to disable backup creation
}

variable "adv_backup_vault_force_destroy" {
  description = "Force destroy recovery points to delete the backup vault"
  default     = false
  type        = bool
}
