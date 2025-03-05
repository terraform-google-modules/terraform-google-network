/*
  Description: Terraform input variables
  NOTE: Louis 2025-02-20 - Should move the region specific option to layer-options.
*/

### Networking Variables
variable "vnet_cidr_block" {
  description = "CIDR block for the customer VNet"
  type        = string
}
variable "vnet_subnets" {
  description = "Customer VNet Subnets, their CIDR blocks, and respective deployment zones. Subnet 'edge' is required."
  type        = map(object({ cidr = string, zone = string }))
}

### Key Pairs
variable "ssh_customer_public_key" {
  description = "SSH public key for customer instances"
}

### Golden AMI Variables
variable "golden_image_resource_group" {
  description = "The resource group of the shared Golden Images for this subscription"
  type        = string
}

##### IAM variables
variable "vnet_gateway_permissions_enable" {
  description = "This appears to be a region specific setting.  We should move this to layer-options."
  type        = bool
  default     = true
}

#### zone support
variable "lb_front_end_ip_zones" {
  description = "(Optional) zones/types for frontend IP. Could be a single zone, zone-redundant or no-zone "
  type        = string
  default     = "Zone-Redundant"
}

### Allows configurable size for usr-sap-trans
variable "nfs_storage_quota" {
  description = "(Optional) The storage capacity quota (in gigabytes) for the NFS Azure file share used by the transport directory (/usr/sap/trans) and SFTP"
  type        = number
  default     = 200
}

#### Lifecycle policy variables in days for Azure Storage Account
variable "tier_to_cool_days" {
  description = "Tier to cool after days since modification greater than"
  type        = number
  default     = 30
}

variable "tier_to_archive_days" {
  description = "Tier to archive after days since modification greater than"
  type        = number
  default     = 60
}

variable "delete_after_days" {
  description = "Delete after days since modification greater than"
  type        = number
  default     = 180
}



### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.

#### Storage Advanced Features
variable "adv_storage_account_https_only_customer_backups" {
  description = "(Optional) Enable HTTPS only for the Backups Storage Account"
  type        = bool
  default     = true
}
variable "adv_storage_account_https_only_customer_nfs" {
  description = "(Optional) Enable HTTPS only for the NFS Storage Account"
  type        = bool
  default     = false
}
variable "adv_min_tls_version" {
  description = "(Optional) The minimum TLS version required for the Storage Account"
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = can(regex("^(TLS1_0|TLS1_1|TLS1_2)$", var.adv_min_tls_version))
    error_message = "The value for the minimum TLS version must be one of 'TLS1_0', 'TLS1_1', 'TLS1_2'."
  }
}
variable "adv_allow_nested_items_to_be_public" {
  description = "(Optional) Allow nested items to be public"
  type        = bool
  default     = false
}

#### Subnet Advanced Features
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
