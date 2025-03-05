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
variable "network" {
  description = "Map of Networks and Subnets. A primary network is required"
  type = map(
    object({                               // network human-readable name. Requires a "primary"
      cidr              = string           // network cidr
      primary_landscape = optional(string) // Primary deployment landscape (where EFS mount targets and VPC endpoints are created). Must be contained within the subnet name. Ex: primary_landscape='production' requires subnet_name='production*'"
      landscape_default_deployment_zones = optional(map(
        object({                // landscape name
          default_zone = string // default subnet zone for the landscape
        })
      ))
      subnets = optional(
        map(              // subnet human-readable name. Note: Subnet name cannot repeat across networks. Ex: if production_1 exists in the "primary" network, it cannot exist in any "secondary" network.
          object({        // Subnet name (must contain the landscape name)
            cidr = string // subnet cidr
            zone = string // subnet zone
          })
      ), null)
      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.
        map(                   // subnet human-readable name. Note: Subnet name cannot repeat across networks. Ex: if production_1 exists in the "primary" network, it cannot exist in any "secondary" network.
          object({
            cidr = string // subnet cidr
            zone = string // subnet zone.  Each Edge Zone must be unique
          })
  ), null) }))

  validation {
    condition     = try(var.network["primary"].primary_landscape != null, false)
    error_message = "A primary network is required and primary_landscape must be defined."
  }
  validation {
    condition     = try(length([for key, value in var.network["primary"].subnets : key if replace(key, var.network["primary"].primary_landscape, "") != key]) > 0, false)
    error_message = "A primary network must include a subnet with a name that begins with the primary_landscape"
  }

  validation {
    condition = length(
      flatten(concat([
        for key_network, value_network in var.network : [
          for key_subnets, value_subnets in value_network.subnets : [
            key_subnets
          ]
      ]]))
      ) == length(distinct(
        flatten(concat([
          for key_network, value_network in var.network : [
            for key_subnets, value_subnets in value_network.subnets : [
              key_subnets
            ]
        ]]))
    ))
    error_message = "Subnets in the network cannot have the same name"
  }

  # Example:
  # network = {
  #   primary = {
  #     primary_landscape = "production"
  #     landscape_default_deployment_zones = {
  #       production = { default_zone = "a" }
  #       quality_assurance = { default_zone = "b" }
  #       development = { default_zone = "c" }
  #     }
  #     cidr = "EXAMPLE_10.1.0.0/19"
  #     subnets = {
  #       production_1        = { zone = "a", cidr = "EXAMPLE_10.1.0.0/23" }
  #       production_2        = { zone = "b", cidr = "EXAMPLE_10.1.2.0/23" }
  #       production_3        = { zone = "c", cidr = "EXAMPLE_10.1.4.0/23"}
  #       quality_assurance_1 = { zone = "a", cidr = "EXAMPLE_10.1.6.0/23"}
  #       quality_assurance_2 = { zone = "b", cidr = "EXAMPLE_10.1.8.0/23"}
  #       quality_assurance_3 = { zone = "c", cidr = "EXAMPLE_10.1.10.0/23"}
  #       development_1       = { zone = "a", cidr = "EXAMPLE_10.1.12.0/23"}
  #       development_2       = { zone = "b", cidr = "EXAMPLE_10.1.14.0/23"}
  #       development_3       = { zone = "c", cidr = "EXAMPLE_10.1.16.0/23"}
  #     }
  #     subnets_edge = {
  #       edge_1 = { zone = "a", cidr = "EXAMPLE_10.1.20.0/26"}
  #       edge_2 = { zone = "b", cidr = "EXAMPLE_10.1.20.64/26"}
  #       edge_3 = { zone = "c", cidr = "EXAMPLE_10.1.20.128/26"}
  #     }
  #   }
  # }
}
variable "custom_no_nat_gateways" {
  description = "Disables the creation of NGWs in the private subnet"
  type        = bool
  default     = false
}
variable "custom_no_local_dns_zone" {
  description = "Use Local Account dns zone"
  type        = bool
  default     = false
}
variable "custom_efs_throughput_mode" {
  description = "Use Local Account EFS throughput mode"
  type        = string
  default     = "provisioned"
}
variable "custom_efs_throughput_in_mibps" {
  description = "Use Local Account EFS throughput in mibps"
  type        = number
  default     = 20
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


#### HA
variable "deploy_ha_efs" {
  description = "Boolean Value. Default False. True to deploy HA-EFS"
  type        = bool
  default     = false
}


##### S3 bucket variables for LCM
variable "bucket_expiration" {
  description = "Enable/Disable customer s3 backup bucket_expiration rule"
  type        = string
  default     = "Disabled"
}

variable "bucket_retention_days" {
  description = "Number of days before objects are deleted from S3 backup bucket"
  type        = number
  default     = 180
}

variable "versioning" {
  description = "Whether versioning is enabled for s3 bucket"
  type        = string
  default     = "Enabled"
}

variable "default_lifecycle_status" {
  description = "Whether default LCM rule is enabled/disabled"
  type        = string
  default     = "Enabled"
}

variable "transition_days_s3ia" {
  description = "Number of days before objects are transitioned to IA"
  type        = number
  default     = 30
}

variable "transition_days_glacier" {
  description = "Number of days before objects are transitioned to glacier"
  type        = number
  default     = 60
}
