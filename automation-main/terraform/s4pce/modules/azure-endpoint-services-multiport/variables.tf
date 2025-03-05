/*
  Description: Variables used by the module to create network load balancers, and private endpoints.
  Comments:
*/

variable "location" {
  description = "(Required) The location/region where the LB will be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group for the load balancer."
  type        = string
}

variable "remote_port" {
  description = "(Optional) Protocols to be used for remote vm access. [protocol, backend_port].  Frontend port will be automatically generated starting at 60000 and in the output."
  type        = map(any)
  default     = {}
}

variable "loadbalancer_name" {
  description = "(Required) Name for the loadbalancer"
  type        = string
}

variable "loadbalancer_probe_unhealthy_threshold" {
  description = "Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy."
  type        = number
  default     = 2
}

variable "loadbalancer_enable_floating_ip" {
  description = "(Optional) Enable floating ip for load balancer or not."
  type        = bool
  default     = false
}

variable "loadbalancer_probe_interval" {
  description = "(Optional) Interval in seconds the load balancer health probe rule does a check"
  type        = number
  default     = 5
}

variable "loadbalancer_idle_timeout_in_minutes" {
  description = "(Optional) idle timeout in mins"
  type        = number
  default     = 5
}

variable "pip_allocation_method" {
  description = "(Optional)  Defines how public IP address is assigned. Options are Static or Dynamic."
  type        = string
  default     = "Dynamic"
}

variable "loadbalancer_type" {
  description = "(Optional) Defined if the loadbalancer is private or public"
  type        = string
  default     = "private"
}

variable "loadbalancer_subnet_id" {
  description = "(Optional) LB subnet id to use when in private mode"
  type        = string
  default     = ""
}

variable "loadbalancer_frontend_private_ip_address_allocation" {
  description = "(Optional) Frontend ip allocation type (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}

variable "loadbalancer_sku" {
  description = "(Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
  type        = string
  default     = "Standard"
}

variable "loadbalancer_probe" {
  description = "(Required) Protocols to be used for lb health probes. Format as [protocol, port, request_path]"
  type        = map(any)
  default     = {}
}

variable "pip_sku" {
  description = "(Optional) The SKU of Azure public ip. Accepted values are Basic and Standard."
  type        = string
  default     = "Standard"
}

variable "loadbalancer_port" {
  description = "(Required) Protocols to be used for lb rules. Format as [frontend_port, protocol, backend_port,backend_pool_name,loadbalancer_frontendip_private_link_map_key]"
  type        = map(any)
}

variable "loadbalancer_frontendip_private_link_map" {
  description = "A map with loadbalancer_frontend_ip_name/private_link_service_name/private_endpoint_name."
  type = map(object({
    loadbalancer_frontend_ip_name = string
    private_link_service_name     = string
    private_endpoint_name         = string
  }))
}


variable "frontend_private_ip_addresses" {
  description = "(Optional) private ip addresses to assign to frontend. Use it with type = private and address allocation is static. "
  type        = list(string)
  default     = [""]
}

variable "loadbalancer_backend_pool_names" {
  description = "(Required)list of names of LB backend pools. "
  type        = list(string)
  default     = ["default-backendpool"]
}

variable "front_end_ip_zones" {
  description = "Zones for loadbalancer frontend IP."
  type        = list(string)
}

variable "enable_domain_name" {
  description = "(Optional) whether to use domain name or not"
  type        = bool
  default     = false
}


variable "domain_name_labels" {
  description = "(Optional) domain name label. This is only needed if we use public IPs/Azure domain names"
  type        = list(string)
  default     = []
}
variable "private_link_endpoint_subnet_id" {
  description = "(Required) Subnet id for the Private Endpoint"
}
variable "private_link_service_subnet_id" {
  description = "(Required) Subnet id for the Private Link Service"
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
