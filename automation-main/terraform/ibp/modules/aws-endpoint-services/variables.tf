/*
  Description: Variables used by the module to create network load balancers, and private endpoints.
  Comments:
*/

##### Generic Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

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
variable "nlb_target_port" {
  description = "Port of the destination target"
}
variable "nlb_listener_port" {
  description = "Port of the destination target"
}
variable "nlb_instance_id" {
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

##### Endpoint (Customer Edge VPC) Variables
variable "endpoint_edge_vpc_id" {
  description = "Edge VPC ID"
}
variable "endpoint_security_group_list" {
  description = "Security groups applied to the endpoint."
}
variable "endpoint_subnet_list" {
  description = "Subnets to place the endpoints into."
}

variable "principal_arns" {
  description = "ARNs of the principals to allow"
  type        = list(string)
  default     = []
}
