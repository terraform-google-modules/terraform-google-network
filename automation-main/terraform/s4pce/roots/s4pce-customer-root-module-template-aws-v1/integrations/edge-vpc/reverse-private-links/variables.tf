/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP Customer VPC
  Comments:
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

variable "reverse_private_link_list" {
  description = "A map of of private links to create"
  default     = null
  type = map(object({
    ip_address          = string
    port_list           = list(string)
    cnames              = list(string)
    private_hosted_zone = string
  }))
  # Example:
  # reverse_private_link_list = {
  #   key1 = {                                        # Keys have 5 character limit
  #     ip_address     = "192.168.108.1"                 # Source IP Address to be forwarded
  #     port_list      = ["22","443"]                    # Source Ports to be forwarded
  #     cnames         = ["myname1","myname2"]           # Additional CNAMEs of the source
  #     private_hosted_zone = "abc"
  #   }
  #   key2 = {
  #     ip_address     = "192.168.108.2"
  #     port_list      = ["80"]
  #     cnames         = [""]
  #     private_hosted_zone = "abc"
  #   }
  # }
}
