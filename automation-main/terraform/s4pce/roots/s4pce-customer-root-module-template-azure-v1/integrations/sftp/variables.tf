/*
  Description: nput variables
  Comments: N/A
*/

### Azure Variables
variable "azure_environment" {
  description = "Azure Cloud Environment (e.g. usgovernment, public)"
  type        = string
}
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

### User Variables
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
  type        = string
}

variable "search_image_name" {
  description = "search_image_name"
  type        = string
}

variable "virtual_machine_size" {
  description = "virtual machine size"
  type        = string
  default     = "Standard_D2ds_v4"
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
  default     = "cloud-user"
}

variable "nonstandard_sftp_list" {
  description = "Custom app to override default app01 in sftp"
  type        = list(string)
  default     = [""]
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.
variable "adv_lb_no_zone" {
  description = "Optional. Do not assign a zone to the loadbalancer"
  type        = bool
  default     = false
}

variable "adv_use_v1_naming" {
  description = "V1 naming excludes DR and does not allow for multiple hosts with the same SID in different landscapes"
  type        = bool
  default     = false
}
