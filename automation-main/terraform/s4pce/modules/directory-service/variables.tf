/*
  Description: Module Variables
  Comments:
*/

### Global Variables
variable "tags" {
  description = "Base Tags to apply to all resources"
  type        = map(string)
  default     = null
}

### Cloudwatch Log Group Variables
variable "create_cloudwatch_log_group" {
  description = "Create Cloudwatch Log Group for Directory Service"
  type        = bool
  default     = true
}

### Constrained Endpoint Variables
variable "create_constrained_endpoint" {
  description = "Create a Windows Constrained Endpoint"
  type        = bool
  default     = false
}
variable "create_constrained_endpoint_dns_records" {
  description = "Create Route53 entries for the Constrained Endpoint"
  type        = bool
  default     = false
}
variable "constrained_endpoint" {
  description = "(Optional) Create a Windows Constrained Endpoint with this configuration"
  type = object({
    instance_profile   = string
    vm_size            = optional(string, "t3a.small")
    key_name           = string
    subnet_id          = string
    security_group_ids = optional(list(string), [])
  })
  default = { instance_profile = "", key_name = "", subnet_id = "" }
}
variable "constrained_endpoint_route53" {
  description = "(Optional) Create a Route53 entries with these values"
  type = object({
    zone_id = string
    cname   = string
  })
  default = { zone_id = "", cname = "constrained" }
}

### Directory Service Variables
variable "directory_service" {
  description = "Create a Directory Service with these values"
  type = object({
    netbios        = string
    admin_password = string
    fqdn           = string
  })
}
variable "directory_service_vpc_id" {
  description = "VPC ID where the directory service will be created"
  type        = string
}
variable "directory_service_subnets" {
  description = "Mutually Exclusive. Either pass in Subnet IDs in two different AZs or pass in Subnet CIDRs to create in two different AZs."
  type = object({
    import_subnet_ids = optional(list(string), [])
    create_subnets = optional(map(object({
      cidr_block = string
      az         = string
    })), {})
  })
  validation {
    condition     = (length(var.directory_service_subnets.import_subnet_ids) == 2 && length(var.directory_service_subnets.create_subnets) == 0) || (length(var.directory_service_subnets.create_subnets) == 2 && length(var.directory_service_subnets.import_subnet_ids) == 0)
    error_message = "Mutually Exclusive. Either 'import_subnet_ids' or 'create_subnets' must declare two subnet ids or cidrs in different AZs"
  }
}

### IAM Workspace Policy Variables
variable "create_workspace_fullaccess_policy" {
  description = "Create IAM Policy allowing all resources access to Directory Service and AWS Workspaces"
  type        = bool
  default     = false
}

### Route53 Outbound Variables
variable "create_outbound_resolver" {
  description = "Create Route53 Outbound Resolver Endpoints"
  type        = bool
  default     = false
}
variable "outbound_resolver" {
  description = "(Optional) Route53 Outbound Resolver Endpoints Configuration."
  type = object({
    security_group_ids = list(string)
    name               = optional(string, null)
  })
  default = null
}


### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.

#### Advanced Cloudwatch Log Group Variables
variable "adv_ds_cloudwatch_log_group_name" {
  description = "(Forces Destroy on Change) Name of the Cloudwatch Log Group. Supercedes Prefix"
  type        = string
  default     = ""
}
variable "adv_ds_cloudwatch_log_group_name_prefix" {
  description = "(Forces Destroy on Change) Prefix of the Cloudwatch Log Group. Superceded by Name"
  type        = string
  default     = "/aws/directoryservice/"
}
variable "adv_ds_cloudwatch_log_group_class" {
  description = "(Forces Destroy on Change) Cloudwatch Log Group Class"
  type        = string
  default     = "STANDARD"
  validation {
    condition     = can(regex("INFREQUENT_ACCESS|STANDARD", var.adv_ds_cloudwatch_log_group_class))
    error_message = "The Cloudwatch Log Group Class must be either 'INFREQUENT_ACCESS' or 'STANDARD'."
  }
}
variable "adv_ds_cloudwatch_log_group_retention" {
  description = "(Forces Destroy on Change) Cloudwatch Log Group Class"
  type        = number
  default     = 14
  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, 0], var.adv_ds_cloudwatch_log_group_retention)
    error_message = "Retention must be in allowed retention values for 'PutRetentionPolicy' API."
  }
}


#### Advanced Constrained Endpoint Variables
variable "adv_constrained_image_search_type" {
  description = "The type of image to search for."
  type        = string
  default     = "name"
  validation {
    condition     = can(regex("name|image-id", var.adv_constrained_image_search_type))
    error_message = "The image search type must be either (default) 'name' or 'image-id'."
  }
}
variable "adv_constrained_image_search_value" {
  description = "The value used by image search. Should be either AMI ID or Name."
  type        = string
  default     = "Windows_Server-2019-English-STIG-Core-*"
}
variable "adv_constrained_image_search_owner_id" {
  description = "The owner ID of the image to search for."
  type        = string
  default     = "amazon"
}

#### Advanced Directory Service Variables
variable "adv_directory_service_description" {
  description = "WARNING: NOT A TAG. This requires a destroy to change. String written to the directory service resource description"
  type        = string
  default     = null
}
variable "adv_directory_service_edition" {
  description = "Either 'Standard' or 'Enterprise' for AWS Microsoft AD"
  type        = string
  default     = "Standard"
}

#### Advanced Metadata Variables
variable "adv_aws_region" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = null
}
variable "adv_aws_partition" {
  description = "AWS Partition where resources will be created"
  type        = string
  default     = null
}
