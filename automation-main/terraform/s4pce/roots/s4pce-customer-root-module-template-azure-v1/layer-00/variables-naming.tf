/*
  Description: Standardized Terraform input variables for Naming and Tagging
  Comments: The contents of this file should not be modified by Operators
*/

variable "label_order" {
  description = "(Default set within context) Ordering of the labels to be picked up by the environment's base_context; used for resource name prefixing"
  type        = list(string)
  default     = null
}
variable "organization" {
  description = "The organization this work belongs to"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "security_boundary" {
  description = "The information security boundary being deployed into"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "business" {
  description = "The line of business resources are being deployed for"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "cloud_provider" {
  description = "(Optional) The cloud provider being deployed into"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "cloud_partition" {
  description = "(Optional) The specific cloud provider partition"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "minor_security_boundary" {
  description = "(Optional) The minor security boundary being deployed into for when a single line of business or business subsection is instantiated more than once within the same security boundary for the purposes of having a staging stack tightly coupled to the production stack"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "business_subsection" {
  description = "(Optional) The sub-security boundary being deployed into for when a single line of business is broken up into multiple logical components"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "account_identifier" {
  description = "(Optional) The specific account that resources are being deployed for for when a single line of business has components separated into separate designated accounts"
  type        = object({ name = string, formatted = string, friendly = string })
  default     = { name = null, formatted = null, friendly = null }
}
variable "customer" {
  description = "(Default within context: scs) Customer that uses the deployed system; e.g. `scs`, `management`, `customer####`"
  type        = object({ name = string, single_tenant = bool, formatted = string, friendly = string })
  default     = { name = null, single_tenant = null, formatted = null, friendly = null }
}
variable "owner" {
  description = "Email address directing communication to the party responsible for the system; e.g., `isso@sapscs.com`, `isse@sapsscs.com`, `dhibpops@sapscs.com`"
  type        = string
}
variable "environment" {
  description = "Environment classification being deployed into; e.g. `development`, `production`"
  type        = string
}
