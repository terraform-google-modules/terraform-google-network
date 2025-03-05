/*
  Description: Terraform input variables
*/

variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
  type        = string
  default     = ""
}

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = null
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes"
  type        = string
  default     = null
}

##### Instance Variables
variable "instance_type" {
  description = "AWS Instance type"
  default     = "t3a.small"
  type        = string
}
variable "host_id" {
  description = "Dedicated Host Id to launch instance on"
  default     = null
  type        = string
}
variable "ec2_key" {
  description = "Name of the AWS keypair to use for the instance"
  type        = string
}
variable "iam_instance_profile" {
  description = "(Optional) IAM Profile to attach to the instance"
  type        = string
  default     = null
}
variable "disable_api_termination" {
  description = "Prevent destroy in AWS Console"
  type        = bool
  default     = false
}
variable "monitoring" {
  description = "Enables detailed cloudwatch monitoring"
  type        = bool
  default     = false
}
variable "placement_group" {
  description = "Which placement group to put the instance in"
  default     = ""
  type        = string
}
variable "enable_state_recovery" {
  description = "Enables cloudwatch hardware state recovery"
  type        = bool
  default     = false
}
variable "auto_reboot_instance_checks" {
  description = "Enables cloudwatch auto-reboot action on instance checks failure"
  type        = bool
  default     = false
}
variable "tenancy" {
  description = "(Optional) The tenancy of the instance. Available values: default, dedicated, host"
  type        = string
  default     = null
}

##### AMI Variables
variable "search_ami_name" {
  description = "The expression to look for the AMI that the instance will use"
  type        = string
}
variable "search_ami_owner_id" {
  description = "The account id of the AMI owner"
  type        = string
}
variable "search_ami_filter_type" {
  description = "Search method for finding the AMI. Options: name/image-id"
  type        = string
  default     = "name"
}
variable "release_lock" {
  description = "(Optional) Version of the operating system to optionally lock package installations and upgrades to"
  type        = string
  default     = null
}

##### Networking Variables
variable "associate_public_ip_address" {
  description = "Create Instance with a dynamically assigned public IP address"
  type        = bool
  default     = false
}
variable "associate_elastic_ip_address" {
  description = "Create Instance with an Elastic IP address"
  type        = bool
  default     = false
}
variable "security_group_ids" {
  description = "List of Security group IDs to apply to the Instance"
  type        = list(string)
}
variable "subnet_id" {
  description = "Subnet ID where the instance should live"
  type        = string
}
variable "source_dest_check" {
  description = "If true, AWS enforces layer3 source/destination checks on traffic passing through the network interface"
  type        = bool
  default     = true
}
variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = string
  default     = null
}
variable "static_private_ip" {
  description = "(Optional) Manually set a static private IP address"
  type        = string
  default     = null
}

##### Root Volume Variables
variable "root_type" {
  description = "Type of Root volume: standard, gp2, io1, sc1, st1"
  default     = "gp3"
  type        = string
}
variable "root_size" {
  description = "Size of Root volume in GiB"
  default     = "100"
  type        = string
}
variable "root_delete_on_termination" {
  description = "Deletes root volume on instance termination"
  type        = bool
  default     = false
}
variable "root_encrypted" {
  description = "Encrypt the root volume"
  type        = bool
  default     = false
}
variable "root_iops" {
  description = "The IOPS to provision for the root volume (only valid for gp3, io1, io2)"
  type        = number
  default     = 3000
}
variable "root_throughput" {
  description = "The throughput to provision for the root volume (only valid for gp3)"
  type        = number
  default     = 125
}
variable "http_endpoint" {
  description = "Indicates whether EC2 Metadata Service is enabled (default) or disabled"
  type        = string
  default     = "enabled"

  validation {
    condition     = var.http_endpoint == "enabled" || var.http_endpoint == "disabled"
    error_message = "Variable http_endpoint must be 'enabled' or 'disabled'."
  }
}
variable "http_tokens" {
  description = "Indicates whether EC2 Metadata Service IDMSv2 is enforced (required) or not (optional)"
  type        = string
  default     = "optional"

  validation {
    condition     = var.http_tokens == "optional" || var.http_tokens == "required"
    error_message = "Variable http_tokens must be 'optional' or 'required'."
  }
}

##### Additional Volume Variables
variable "additional_volumes" {
  description = "Map of additional volumes to attach to instance (size = number, type = string, iops = number, throughput = number, encrypted = bool)"
  # type = map(
  # object( ## Commented until module_variable_optional_attrs is stable, and released. See https://github.com/hashicorp/terraform/issues/19898#issuecomment-1230402327
  #   {
  #     az         = optional(string)
  #     size       = number
  #     type       = optional(string)
  #     iops       = optional(number)
  #     throughput = optional(number)
  #     encrypted  = optional(bool)
  #   }
  # )
  # ) # where dict key is the device name. i.e. sda, sdb, etc.
  default = {}
  validation {
    condition     = alltrue([for device_name, ebs in var.additional_volumes : lookup(ebs, "size", false) != false ? true : false])
    error_message = "Size is required for additional_volumes map, all other variables are optional."
  }
}

##### Route53 Variables
variable "route53_associate_private_ip_address" {
  description = "Create DNS A record for instance ID in passed Route53 zone"
  type        = bool
  default     = false
}
variable "route53_zoneid" {
  description = "Zone ID for the Route53 zone for creating DNS records. Must be set when route53_associate_private_ip_address is set to true."
  default     = ""
  type        = string
}
variable "route53_ttl" {
  description = "Value for Route53 TTL in seconds"
  type        = string
  default     = "300"
}
variable "route53_associate_cname" {
  description = "Only if route53_associate_private_ip_address is set to true, create standard CNAME for created DNS A record using passed instance tags."
  type        = bool
  default     = false
}
variable "route53_additional_cnames" {
  description = "Only if route53_associate_cname is satisfied and set to true, additional list of custom CNAMEs to provision for created DNS A record."
  type        = list(string)
  default     = []
}

##### Bootstrap Variables
variable "bootstrap_enable" {
  description = "Flag to turn instance bootstrap process via userdata on/off, `true` - enables boostrap, `false` - disables bootstrap"
  type        = bool
  default     = false
}
variable "custom_bootstrap" {
  description = "When defined and `bootstrap_enable` is set to `true`, allows for a custom base64 encoded bootstrap string to be applied to the instance via userdata"
  type        = string
  default     = ""
}
# pre-defined bootstrap options
variable "git_repository" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git repository to download, leave out 'http(s)' url prefix"
  type        = string
  default     = ""
}
variable "git_branch" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, specific branch of git repository to download"
  type        = string
  default     = "master"
}
variable "git_repository_path" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, path on system where to clone git repository to if specified"
  type        = string
  default     = ""
}
variable "git_repository_cleanup" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, flag to tell boostrap process to removed cloned repository from system when finished"
  type        = bool
  default     = true
}
variable "git_name" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git username to download repositories"
  type        = string
  default     = ""
}
variable "git_token" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git token to download repositories"
  type        = string
  default     = ""
}
variable "bootstrap_commands" {
  description = "When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, list of bash commands to execute (runs within root of downloaded git repository if repo specified)"
  type        = list(string)
  default     = []
}
