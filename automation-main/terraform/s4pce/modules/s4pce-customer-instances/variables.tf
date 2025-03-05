/*
  Description: Terraform input variables
  Comments:
    Requires null context
*/

##### Instance Variables
variable "image_database_name" {
  description = "Search string for Database image"
  type        = string
}
variable "image_application_name" {
  description = "Search string for SAP Application image"
  type        = string
}
variable "ssh_main01_public_key" {
  description = "SSH public key to create an AWS EC2 Key from and associate with management instances"
}
variable "ssh_keypair_name" {
  description = "AWS Keypair Name"
  type        = string
  default     = null
}
variable "ami_owner_default" {
  description = "Default AMI Owner to use"
  default     = "156506675147"
}
variable "instance_list" {
  description = "A map of instances to create"
  type        = any
  default     = null
  #Example:
  // instance_list = {
  //   instance01 = {
  //     os          = "rhel"                             # Optional Defaults to rhel. Used to determine patch group.  Options are: [rhel, ubuntu, windows]
  //     sid         = "n01"                              # Required.  SID of the Instance
  //     name        = "hana"                             # Used for tagging.  Typically: [hana, app, webdispatcher, cloudconnector]
  //     hostname    = "alternate-hostname"               # Optional.  If not specified the key will be used as the hostname
  //     productname = "s4"                               # Product Tagging.  Examples: [s4, bw4, ads]
  //     description = "Test Instance"
  //     landscape   = "Quality-Assurance"                # Used to determine subnet. Options are: [Production, Quality-Assurance, Development]
  //     az             = "1a"                            # Optional. Do not include to use predetermined AZ based on landscape.
  //     ami            = "Golden-SHC-RHEL-8.1-HANA-V*"   # Optional. If not declared, will use "hana" or "app" AMI based off the name above.
  //     ami_owner      = "156506675147"                  # Optional. Do not include to use default owner
  //     instance_type  = "t3.micro"
  //     securitygroups = []                              # Optional. Used to apply additional Security groups on top of the defaults
  //     cnames         = []                              # Optional.
  //   }
  // }
}
variable "rhel_patch_group" {
  description = "rhel patch group"
}
variable "windows_patch_group" {
  description = "windows patch group"
}
variable "ubuntu_patch_group" {
  description = "ubuntu patch group"
}
variable "instance_security_groups_list" {
  description = "list of security groups to attach to the instances"
}
variable "instance_route53_zone_id" {
  description = "route53 zone id for instances"
}
variable "instance_iam_role" {
  description = "IAM role to attach to the instance"
}

##### HA Instances List
variable "ha_instances" {
  description = "Used to disable source/destination checking on HA instances"
  type        = list(string)
  default     = []
}

##### SAP Router Variables
variable "saprouter_ingress_cidr" {
  description = "Allowed Ingress for SAP Router"
  type        = list(string)
  default     = ["194.39.131.34/32"]
}

##### Network Variables
variable "vpc_id" {
  description = "The VPC ID"
}

variable "subnets" {
  description = "The VPC ID"
  type = map(
    object({
      name = string
      id   = string
    })
  )
}

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