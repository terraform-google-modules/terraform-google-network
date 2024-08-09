variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "address_name" {
  description = "Global address name"
  type        = string
}

variable "address_purpose" {
  description = "Global address purpose"
  type        = string
  default     = "VPC_PEERING"
}

variable "address_type" {
  description = "Global address type"
  type        = string
  default     = "INTERNAL"
}

variable "address_prefix_length" {
  description = "Global address prefix length"
  type        = number
  default     = 16
}

variable "network_name" {
  description = "Network name"
  type        = string
  default     = null
}

variable "network_id" {
  description = "Network id"
  type        = string
}

variable "deletion_policy" {
  description = "Deletion policy for service networking resource"
  type        = string
  default     = null
}

variable "create_peering_routes_config" {
  description = "Create peering route config"
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Import custom routes to peering rout config"
  type        = bool
  default     = false
}

variable "export_custom_routes" {
  description = "Export custom routes"
  type        = bool
  default     = false
}

variable "create_peered_dns_domain" {
  description = "Create peered dns domain"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = null
}

variable "dns_suffix" {
  description = "Dns suffix"
  type        = string
  default     = null
}
