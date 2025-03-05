/*
  Description: Variables used by the module to create network load balancers, and private endpoints.
  Comments:
*/

##### Network Load Balancer Variables
variable "nlb_subnet_list" {
  description = "Subnets the load balancer will reside in."
}
variable "nlb_name" {
  description = "Name of the Network Load Balancer"
}
variable "nlb_deletion_protection" {
  description = "Enables/Disables termination protection"
  type        = bool
  default     = false
}
variable "nlb_port_list" {
  description = "List of ports to listen and forward to"
}
variable "nlb_target_id" {
  description = "Instance or IP address to forward the Network Load Balancer to."
}
variable "nlb_target_ip" {
  description = "Target IP address instead of instance type"
  default     = false
}
variable "nlb_target_az_all" {
  description = "Sets the AZ to `all`. Required if IP is outside the VPC"
  default     = false
}
variable "nlb_enable_cross_zone_load_balancing" {
  description = "Enables cross zone load balancing on the load balancer"
  type        = bool
  default     = true
}
variable "nlb_health_check_port" {
  description = "(Optional) Port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port."
  type        = string
  default     = "traffic-port"
}

##### Endpoint (Customer Edge VPC) Variables
variable "endpoint_create" {
  description = "Create a VPC Endpoint"
  type        = bool
  default     = true
}
variable "endpoint_edge_vpc_id" {
  description = "Edge VPC ID"
  type        = string
  default     = null
}
variable "endpoint_security_group_list" {
  description = "Security groups applied to the endpoint."
  type        = list(string)
  default     = []
}
variable "endpoint_subnet_list" {
  description = "Subnets to place the endpoints into."
  type        = list(string)
  default     = []
}
variable "principal_arns" {
  description = "ARNs of the principals to allow"
  type        = list(string)
  default     = []
}
