/*
Description : variables
*/
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "az_location" {
  description = "azure region."
  type        = string
  default     = "eastus"
}


variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
}


variable "address_space" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["samprivate_link_endpoint-subnet"]
}

variable "subnet_ids" {
  description = "A list of public subnet ids inside the vNet."
  type        = list(string)
  default     = []
}

variable "skip_provider_registration" {
  type    = bool
  default = false
}


##########
variable "vnet_name2" {
  description = "Name of the vnet to create"
  type        = string
  default     = "samprivate_link_endpoint-vnet"
}


variable "address_space2" {
  type        = string
  description = "The address space that is used by the virtual network."
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes2" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_names2" {
  description = "A list of public subnets inside the vNet."
  type        = list(string)
  default     = ["samprivate_link_endpoint-subnet"]
}

variable "subnet_ids2" {
  description = "A list of public subnet ids inside the vNet."
  type        = list(string)
  default     = []
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  description = "A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false."
  type        = map(bool)
  default     = {}
}
