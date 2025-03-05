/*
  Description: Terraform input variables
*/

variable "tags" {
  type        = map(string)
  description = "A collection of tags to apply"
}
variable "region" {
  type        = string
  description = "The Azure region to deploy resources"
}
variable "build_user" {
  type        = string
  description = "The user who initiated the build"
}

##### VNet Variables
variable "vnet_cidr_blocks" {
  description = "CIDR blocks for the customer VNet. Can include IPv6"
  type        = list(string)
}
variable "vnet_subnets" {
  description = "Configuration block for provisioning the customer subnets, subnet 'edge' is required"
  type = map(
    object({               // subnet human-readable name
      cidr = list(string), // Can be one IPv4 and one IPv6 CIDR. IPv6 must be /64
      zone = string        // subnet zone
  }))
}

variable "use_custom_dhcpoptions_dns" {
  description = "Use Custom DNS Values for DHCP Options"
  type        = list(string)
  default     = []
}
variable "deploy_nat_gateways" {
  description = "Default:True  Deploys Nat Gateways per zone"
  type        = bool
  default     = true
}

variable "deploy_private_route_tables" {
  description = "Default:True  Creates (private) route tables per zone."
  type        = bool
  default     = true
}
variable "associates_private_route_tables" {
  description = "Default:True  Associates each private (non-edge) subnet to a route table."
  type        = bool
  default     = true
}
variable "use_default_security_rules" {
  description = "Default:True  Use default security rules for the ASG. Allow all egress. Allow all intra-VPC"
  type        = bool
  default     = true
}
