/*
  Description: Terraform input variables
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### VPC Variables
variable "loadbalancer_cert_fqdn" {
  description = "FQDN of the loadbalancer cert"
}

##### Instance Variables
variable "image_database_name" {
  description = "Search string for Database image"
  type        = string
}
variable "image_database_owner" {
  description = "Owner for Database AMI"
  type        = string
  default     = "156506675147"
}
variable "image_application_name" {
  description = "Search string for SAP Application image"
  type        = string
}
variable "image_application_owner" {
  description = "Owner for SAP Application AMI"
  type        = string
  default     = "156506675147"
}
variable "ssh_main01_public_key" {
  description = "SSH public key to create an AWS EC2 Key from and associate with management instances"
}
variable "git_name" {
  description = "Git username to download repositories; define if performing bootstrap through userdata."
}
variable "git_token" {
  description = "Git token to download repositories; define if performing bootstrap through userdata."
}

variable "cpids_lb_subnets" {
  description = "Subnet (key) where to create cpids loadbalancers. Key matches subnet created in layer-00. Restrict one mount target per zone."
  type        = list(string)
  default     = ["dataservices_1", "dataservices_2"]
}

variable "instance_map" {
  description = "A map of instances to create. See instance.auto.tfvars for default example."
  type = map(object({
    metadata_key    = string
    image_type      = string
    subnet_lookup   = string
    tag_name        = string
    tag_description = string
    instance_type   = string
    cnames          = list(string)
  }))
}
