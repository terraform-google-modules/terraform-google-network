/*
  Description: Tagging variables
  Comments:
*/

variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### Naming and Tagging Variables
variable "organization" {
  description = "Name of the organization work this work belongs to; will be used as part of naming prefix in special cases requiring globally unique resources to avoid clashing outside of the organization"
  type        = string
}
variable "organization_friendly_name" {
  description = "Human readable friendly name of the organization this work belongs to"
  type        = string
}
variable "security_boundary" {
  description = "Name of the security boundary being deployed into; will be used as part of naming prefix for all resources"
  type        = string
}
variable "security_boundary_friendly_name" {
  description = "Human readable friendly name of the security boundary being deployed into"
  type        = string
}
variable "business" {
  description = "Name of the line of business resources are being deployed for; will be used as part of naming prefix for all resources"
  type        = string
}
variable "business_subsection" {
  description = "Name of the line of business subsection"
  type        = string
}
variable "business_friendly_name" {
  description = "Human readable friendly name of the line of business resources are being deployed for"
  type        = string
}
variable "customer" {
  description = "Customer that uses the deployed system; e.g. `ns2`, `management`, `customer00006`"
  type        = string
}
variable "owner" {
  description = "Email address directing communication to the party responsible for the system; e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com`"
  type        = string
}
variable "environment" {
  description = "Environment classification being deployed into; e.g. `development`, `production`"
  type        = string
}
