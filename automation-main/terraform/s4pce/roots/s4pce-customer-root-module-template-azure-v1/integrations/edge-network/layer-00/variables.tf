/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/

### Networking Variables
variable "vnet_cidr_block" {
  description = "CIDR block for the customer VNet"
  type        = string
}
# variable "vnet_subnets" {
#   description = "Customer VNet Subnets, their CIDR blocks, and respective deployment zones. Subnet 'edge' is required."
#   type        = map(object({ cidr = string, zone = string }))
# }

variable "vnet_ingress_cidr_list" {
  description = "CIDR block allowed to ingress to VPC Endpoints"
  type        = list(string)
}
variable "subnet_main01_cidr_block" {
  description = "CIDR block for the main01 subnet"
}
variable "subnet_gateway_cidr_block" {
  description = "CIDR block for the gateway subnet"
}

### LB Variables
variable "lb_pool_node_type" {
  description = "Type of nodes to be added to LB backend pool. Valid values are 'primary','dr', 'both'"
  type        = string

  validation {
    condition     = length(regexall("^(primary|dr|both)$", var.lb_pool_node_type)) > 0
    error_message = "ERROR: Valid types are \"primary\", \"dr\" and \"both\"!"
  }
  default = "primary"
}

### Virtual Network Gateway Variables
variable "vng_asn" {
  description = "ASN number for the customer router BGP configuration"
  type        = number
  default     = 65515
}

variable "vng_sku" {
  description = "VNG SKU"
  type        = string
  default     = "VpnGw2AZ"
}


### Legacy Variables
# NOTE: These are for existing deployments with legacy resources; DO NOT USE FOR NEW DEPLOYMENTS
variable "legacy_endpoints" {
  description = "List of legacy endpoints"
  type        = list(string)
  default     = []
}
variable "legacy_migration" {
  description = "Toggle for creation of resources to assist in migration from legacy code"
  type        = bool
  default     = false
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.
variable "adv_no_customer_gateway" {
  description = "(Optional) Do not deploy virtual network gateway for customer"
  type        = bool
  default     = false
}

variable "adv_subnet_endpoint_network_policies" {
  description = "(Optional) Enable/Disable network policies for private endpoints"
  type        = string
  default     = "Disabled"
  validation {
    condition     = can(regex("^(Enabled|Disabled|NetworkSecurityGroupEnabled|RouteTableEnabled)$", var.adv_subnet_endpoint_network_policies))
    error_message = "The value for the private endpoint network policies must be one of 'Enabled', 'Disabled' 'NetworkSecurityGroupEnabled' 'RouteTableEnabled'"
  }
}
variable "adv_subnet_service_network_policies" {
  description = "(Optional) Enable/Disable network policies for service endpoints"
  type        = bool
  default     = false
}
