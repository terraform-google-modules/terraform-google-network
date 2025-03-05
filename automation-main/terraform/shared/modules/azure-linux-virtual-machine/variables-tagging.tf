/*
  Description: Terraform tagging input variables
*/

variable "tag_description" {
  description = "Friendly description of the purpose of the system"
  type        = string
  default     = null
}
variable "tag_business" {
  description = "Line of business which the resource is related to e.g., `ns2`, `ibp`, `scp`, `sac`, `hcm`"
  type        = string
  default     = null
}
variable "tag_customer" {
  description = "Customer that uses the deployed system e.g., `management`, `customer00006`"
  type        = string
  default     = null
}
variable "tag_environment" {
  description = "Related management plane e.g., `staging`, `production`, `management`"
  type        = string
  default     = null
}
variable "tag_owner" {
  description = "Email address directing communication for that party responsible for the system e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com`"
  type        = string
  default     = null
}
variable "tag_platform" {
  description = "Used by the Asset Management team e.g., `licensed` (Windows) or `unlicensed` (Red Hat Linux)"
  type        = string
  default     = null
}
variable "tag_productname" {
  description = "Application/product name being deployed e.g., `hana`, `nessus`, `concourse`"
  type        = string
  default     = null
}
variable "tag_managedby" {
  description = "Indicates what technology is used to continuously configure the resource if not terraform e.g., `ansible`, `chef`"
  type        = string
  default     = "terraform"
}
variable "tag_patchgroup" {
  description = "Group of systems that should be patched together during scheduled maintenance windows"
  type        = string
  default     = null
}
variable "tag_productcluster" {
  description = "A more granular name of the specific cluster/deployment of a product when deploying the same product multiple times in a single hosted zone and clarification is needed. e.g., `pki` a second Hashicorp Vault deployed specifically for PKI"
  type        = string
  default     = null
}
variable "tag_productcomponent" {
  description = "The name of the subcomponent of the product only when product is broken into multiple subcomponents. e.g., `web`, `worker` (Concourse), `indexer` (Splunk)"
  type        = string
  default     = null
}
variable "tag_productvendor" {
  description = "The name of the vendor/brand of the product. e.g., `tenable`, `sap`, `hashicorp`"
  type        = string
  default     = null
}
variable "tag_productversion" {
  description = "Specific version or variant of product e.g., `8.1.2`, `R40`, `v3.0`"
  type        = string
  default     = null
}
