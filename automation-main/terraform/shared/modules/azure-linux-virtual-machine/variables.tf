/*
  Description: Terraform input variables
*/

variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
  type        = string
  default     = ""
}

##### Azure Variables
variable "location" {
  description = "Azure location where the Linux Virtual Machine should exist"
  type        = string
}
variable "resource_group_name" {
  description = "Name of the Resource Group in which the Linux Virtual Machine should be exist"
  type        = string
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined if not using null-context for auditing purposes"
  type        = string
  default     = null
}

##### Tagging Variables
variable "name" {
  description = "Name of the Linux Virtual Machine"
  type        = string
}

##### Virtual Machine Variables
variable "size" {
  description = "SKU which should be used for the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}
variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine"
  type        = string
  default     = "cloud-user"
}
variable "public_key" {
  description = "The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format"
  type        = string
}
variable "dedicated_host_id" {
  description = "(Optional) Dedicated Host Id to launch Virtual Machine on"
  type        = string
  default     = null
}
variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to"
  type        = string
  default     = null
}

##### Identity Variables
variable "system_assigned_identity_permissions" {
  description = "(Optional) A map of role definition names and their scope to assign to the System Managed Identity. Scope can be set to 'self' to apply permissions scoped to this virtual machine."
  type        = map(string)
  default     = {}
}
variable "user_managed_identity_ids" {
  description = "(Optional) A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine"
  type        = list(string)
  default     = []
}

##### Image Variables
variable "search_image_name" {
  description = "The expression to look for the image that the virtual machine will use"
  type        = string
}
variable "image_resource_group_name" {
  description = "Name of the Resource Group in which the Linux Virtual Machine Image exists"
  type        = string
}

##### Networking Variables
variable "subnet_id" {
  description = "Subnet ID where the virtual machine should live"
  type        = string
}
variable "zone" {
  description = "The Zone in which this Virtual Machine should be created"
  type        = string
  default     = null
}
variable "associate_public_ip_address" {
  description = "Create Network Interface with a public IP address"
  type        = bool
  default     = false
}
variable "associate_static_public_ip_address" {
  description = "Create Network Interface with a Static public IP address"
  type        = bool
  default     = false
}
variable "network_security_group_id" {
  description = "(Optional) Network Security group ID to apply to the Virtual Machine"
  type        = string
  default     = null
}
variable "application_security_groups" {
  description = "(Optional) Map of Application Security group ID to apply to the Virtual Machine"
  type        = map(string)
  default     = {}
}
variable "static_private_ip_address" {
  description = "(Optional) Manually set a static private IP address"
  type        = string
  default     = null
}

##### Root Volume Variables
variable "encryption_at_host_enabled" {
  description = "Whether to ensure all of the disks (including the temp disk) attached to this Virtual Machine are encrypted by enabling EncryptionAtHost"
  type        = bool
  default     = true
}
variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS"
  type        = string
  default     = "Standard_LRS"

  validation {
    condition     = var.os_disk_storage_account_type == "Standard_LRS" || var.os_disk_storage_account_type == "StandardSSD_LRS" || var.os_disk_storage_account_type == "Premium_LRS"
    error_message = "The os_disk_storage_account_type must be either 'Standard_LRS', 'StandardSSD_LRS' or 'Premium_LRS'."
  }
}
variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
  type        = string
  default     = "ReadWrite"

  validation {
    condition     = var.os_disk_caching == "None" || var.os_disk_caching == "ReadOnly" || var.os_disk_caching == "ReadWrite"
    error_message = "The os_disk_caching must be either 'None', 'ReadOnly' or 'ReadWrite'."
  }
}
variable "os_disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from"
  type        = string
  default     = "100"
}

##### DNS Variables
variable "dns_associate_private_ip_address" {
  description = "Create DNS A record for virtual machine ID in supplied DNS Zone"
  type        = bool
  default     = false
}
variable "dns_zone" {
  description = "DNS Zone for creating DNS records. Must be set when dns_associate_private_ip_address is set to true"
  type        = string
  default     = ""
}
variable "dns_ttl" {
  description = "Value for TTL in seconds"
  type        = string
  default     = "300"
}
variable "dns_associate_cname" {
  description = "Only if dns_associate_private_ip_address is set to true, create standard CNAME for created DNS A record using passed virtual machine tags"
  type        = bool
  default     = false
}
variable "dns_additional_cnames" {
  description = "Only if dns_associate_private_ip_address is set to true, additional list of custom CNAMEs to provision for created DNS A record"
  type        = list(string)
  default     = []
}

### Bootstrap Variables
variable "bootstrap_enable" {
  description = "Flag to turn virtual machine bootstrap process via userdata on/off, `true` - enables boostrap, `false` - disables bootstrap"
  type        = bool
  default     = false
}
variable "custom_bootstrap" {
  description = "When defined and `bootstrap_enable` is set to `true`, allows for a custom base64 encoded bootstrap string to be applied to the virtual machine via userdata"
  type        = string
  default     = ""
}
# pre-defined bootstrap options
variable "git_repository" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git repository to download, leave out 'http(s)' url prefix"
  type        = string
  default     = ""
}
variable "git_branch" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, specific branch of git repository to download"
  type        = string
  default     = "master"
}
variable "git_repository_path" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, path on system where to clone git repository to if specified"
  type        = string
  default     = ""
}
variable "git_repository_cleanup" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, flag to tell boostrap process to removed cloned repository from system when finished"
  type        = bool
  default     = true
}
variable "git_name" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git username to download repositories"
  type        = string
  default     = ""
}
variable "git_token" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git token to download repositories"
  type        = string
  default     = ""
}
variable "bootstrap_commands" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, list of bash commands to execute (runs within root of downloaded git repository if repo specified)"
  type        = list(string)
  default     = []
}

variable "availability_set_id" {
  description = "availability set id"
  type        = string
  default     = null
}

variable "adv_public_ip_zones" {
  description = "(Optional) Availability Zones for the Public IP Address."
  type        = list(string)
  default     = []
}
