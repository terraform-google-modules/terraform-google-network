

# Metadata Values
variable "build_user" {
  description = "Employee ID for Tagging"
  type        = string
}
variable "tags" {
  description = "Tags to apply to all resources where applicable"
  type        = map(string)
}
variable "context" {
  description = "Null Context for VM creation.  Will be phased out eventually"
  type        = any
}
variable "vpc_info" {
  description = "VPC Info where resources will be created"
  type = object({
    id         = string
    cidr_block = string
  })
}
variable "subnet_info" {
  description = "Subnet Info where resources will be created"
  type = object({
    id = string
  })
}
# Virtual Machine Values
variable "vm_values" {
  description = <<-EOT
    Values for QTM virtual machines.
    (Set of 3. qtm_database, qtm_application, qtm_webdispatcher)
    Optional ami values will default to either
    the image_database or image_application variables
  EOT
  type = object({
    qtm_database = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
    qtm_application = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
    qtm_webdispatcher = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
  })
}
variable "ec2_key" {
  description = "EC2 key pair name assigned to the instances"
  type        = string
}
variable "egress_cidrs" {
  description = <<-EOT
    Map of CIDRs the QTM Instances are allowed to connect to.
    This will typically be the IP Address of at least one backend system.
  EOT
  type        = map(string)
  default     = {}
}
variable "iam_instance_profile" {
  description = "ARN of the Instance Profile to attach to the QTM Instances"
  type        = string
}
variable "alb_info" {
  description = <<-EOT
    Values for the Application Load Balancer
    subnet_mappings - List of Subnet IDs to attach the ALB to. Minimum of 2 different zones.
    certificate_arn - TLS certificate to attach to the Listener
  EOT
  type = object({
    subnet_mappings   = list(string)
    certificate_arn   = string
    adv_listener_port = optional(number, 443)
    adv_target_port   = optional(number, 44301)
    adv_health_check = optional(list(map(string)), [{
      enabled             = true
      healthy_threshold   = 5
      unhealthy_threshold = 2
      timeout             = 5
      interval            = 30
      path                = "/sap/public/ping"
      protocol            = "HTTPS"
      port                = 44301
    }])
  })
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide additional configuration options
# or compensate lack of feature parity.
variable "adv_random_prefix" {
  description = "Optional. Allows a prefix for generated random IDs."
  type        = string
  default     = null
}
variable "adv_image_database" {
  description = "Default image for database VMs"
  type = object({
    name  = string
    owner = string
  })
  default = {
    name  = "Golden-SCS-RHEL-8.6-HANA-V*"
    owner = "156506675147"
  }
}
variable "adv_image_application" {
  description = "Default image for application VMs"
  type = object({
    name  = string
    owner = string
  })
  default = {
    name  = "Golden-SCS-RHEL-8.6-SAPAPP-V*"
    owner = "156506675147"
  }
}
variable "adv_alb_ingress_cidrs" {
  description = "IPv4 CIDRs to allow ingress to the ALB"
  type        = map(string)
  default     = { default = "0.0.0.0/0" }
}
