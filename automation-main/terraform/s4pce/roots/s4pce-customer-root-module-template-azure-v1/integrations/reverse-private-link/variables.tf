/*
  Description: nput variables
  Comments: N/A
*/

variable "reverse_private_link_list" {
  description = "A map of of private links to create"
  default     = null
  type = map(object({
    ip_address          = string
    port_list           = list(string)
    cnames              = list(string)
    private_hosted_zone = string
  }))
}
variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine"
  type        = string
  default     = "cloud-user"
}

variable "enable_proxy" {
  description = "Use Envoy Proxy instead of IPTables Proxy"
  type        = bool
  default     = false
}
variable "image_proxy" {
  description = "Search string for Proxy VM image"
  type        = string
}
variable "envoy_proxy_values" {
  description = "Values for Envoy Proxy"
  type = object({
    custom_nameservers = list(string)
    app_keyid          = string
    app_repo           = string
    app_branch         = string
    app_package        = string
  })
}
