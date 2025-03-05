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

##### Gateway Variables
variable "vgw_asn" {
  description = "Amazon side ASN to assign to the VGW"
  type        = string
  default     = null
}

##### Subnet Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}
variable "vpc_ingress_cidr_list" {
  description = "CIDR block allowed to ingress to VPC Endpoints"
}


variable "subnet_main01_infrastructure_1a_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1a subnet"
}
variable "subnet_main01_infrastructure_1b_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1b subnet"
}
variable "subnet_main01_infrastructure_1c_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1c subnet"
}

##### HA Endpoints
variable "ha_endpoints" {
  description = "HA endpoints"
  type = map(
    object({
      vhost   = string
      address = string
      ports   = optional(list(string), ["3301", "3601"]) # This is the default when ports is not specified
  }))
  default = {}
}

##### Load Balancer Variables
variable "loadbalancer_names" {
  description = "List of load balancer unique names to be converted to Private Links. The loadbalancers should be unique to the Customer"
  type        = list(string)
  default     = []
}
