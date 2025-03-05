/*
  Description: Module Variables
  Comments:
*/

variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}
variable "docker_bastion_list" {
  description = "Name List of Docker Bastions"
  type        = list(string)
  default     = []
}
variable "image_ubuntu" {
  description = "Ubuntu AMI to use for Docker Bastion"
  type        = string
}
variable "key_name" {
  description = "Key Pair Name"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "security_groups" {
  description = "Security Groups IDs"
  type        = list(string)
  default     = []
}
variable "adv_vm_size" {
  description = "(Optional) Virtual Machine Size"
  type        = string
  default     = "t3a.small"
}
variable "adv_iam_instance_profile" {
  description = "(Optional) IAM Profile"
  type        = string
  default     = null
}
variable "adv_public_ip" {
  description = "(Optional) Add a Public IP to the instance"
  type        = bool
  default     = false
}
variable "build_user" {
  description = "User ID of Terraform Build User"
  type        = string
}
