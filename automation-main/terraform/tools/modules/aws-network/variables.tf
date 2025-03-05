/*
  Description: Variables for the terraform-aws-pce-customer-interface modules
  Comments: N/A
*/

##### Required Variables
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}
variable "aws_region" {
  description = "AWS Region where the module is run"
}
variable "network" {
  description = "Map of Networks and Subnets. A primary network is required"
  type = map(
    object({                                   // network human-readable name. Requires a "primary"
      cidr      = string                       // network cidr
      ipv6_ipam = optional(string, "disabled") // network ipv6 cidr.  Only accepts "aws" for aws generated ipv6 for now.
      subnets = optional(
        map( // subnet human-readable name
          object({
            cidr        = string                 // subnet cidr
            zone        = string                 // subnet zone
            ipv6_netnum = optional(string, null) // Optional ipv6 subnet number. Auto-generates from allocated ipv6 CIDR.
          })
      ), null)
      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.
        map(                   // subnet human-readable name
          object({
            cidr        = string                 // subnet cidr
            zone        = string                 // subnet zone.  Each Edge Zone must be unique
            ipv6_netnum = optional(string, null) // Optional ipv6 subnet number. Auto-generates from allocated ipv6 CIDR.
          })
  ), null) }))
}

variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
}

##### Optional Variables
variable "deploy_nat_gateways" {
  description = "Creates NAT/Egress Only Gateway deployment per zone"
  type        = bool
  default     = true
}
variable "use_default_security_rules" {
  description = "Create default security group rules.  All egress. All intra-VPC"
  type        = bool
  default     = true
}
variable "deploy_private_route_tables" {
  description = "Creates (private) route tables per zone."
  type        = bool
  default     = true
}
variable "associates_private_route_tables" {
  description = "Associates each private (non-edge) subnet to a route table."
  type        = bool
  default     = true
}
variable "custom_dhcpoptions_id" {
  description = "AWS ID of alternative dhcptions to associate with VPC"
  type        = string
  default     = ""
}
