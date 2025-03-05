/*
  Description: Terraform input variables
*/

##### VNet Variables
variable "vnet_cidr_block" {
  description = "CIDR block for the customer VNet"
}
variable "vnet_subnets" {
  description = "Configuration block for provisioning the customer subnets, subnet 'edge' is required"
  type        = map(object({ cidr = string, zone = string }))
}


##### DNS variables
variable "dns_zone" {
  description = "(Optional) FQDN of the private hosted zone for the DNS Domain"
  type        = string
  default     = null
}


##### IAM variables
variable "vnet_gateway_permissions_enable" {
  description = "(Optional) This seems to be a region specific customization. Need to move it to Layer-Options"
  type        = bool
  default     = false
}


#### Storage Account variables
variable "versioning" {
  description = "(Optional) Whether or not versioning is enabled for Storage Account"
  type        = bool
  default     = false
}

variable "nfs_storage_quota" {
  description = "(Optional) The storage capacity quota (in gigabytes) for the NFS Azure file share used by the transport directory (/usr/sap/trans) and SFTP"
  type        = number
  default     = 100

  validation {
    condition     = var.nfs_storage_quota >= 100
    error_message = "The value for the storage capacity quota must be at least 100 (gigabytes)."
  }
}

#### Lifecycle policy variables in days for Azure Storage Account
variable "lifecyeclepolicy" {
  description = "(Optional) Whether or not lifecyle policy is enabled for main storage bucket"
  type        = bool
  default     = true
}

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

variable "create_nat_gateway" {
  description = "whether to create nat gateways or not"
  type        = bool
  default     = true
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.


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
