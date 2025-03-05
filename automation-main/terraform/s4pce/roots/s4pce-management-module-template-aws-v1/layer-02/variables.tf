/*
  Description: Terraform input variables
  Comments: N/A
*/

##### Mandatory Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

### Key Pairs
variable "ssh_management_public_key" {
  description = "SSH public key to create an AWS EC2 Key from and associate with management instances"
}

##### Instance Variables

variable "image_metadata" {
  description = "Metadata for images to search for"
  type = object({
    database_image    = string
    application_image = string
    openvpn_image     = string
    base_image        = string
  })
}
variable "image_owner_default" {
  description = "Default AMI Owner to use"
  default     = "156506675147"
}


variable "backup_metadata" {
  description = "Management Backup Metadata"
  type = object({
    schedule              = optional(string, "cron(0 5 ? * 7 *)")
    frequency_description = optional(string, "Weekly at midnight on Fridays")
    completion_window     = optional(number, 720)
    delete_after          = optional(number, 90)
    selection_name        = optional(string, null)
  })
  default = {}
}
