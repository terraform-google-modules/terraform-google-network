/*
  Description: Terraform input variables
  Comments:
    Requires null context
*/

##### Module Dependecy
variable "module_dependency" {
  description = "Used by root modules to create a dependency for order of operation purposes"
  default     = ""
}

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
  default     = "us-gov-west-1"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### VPC Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the Customer VPC"
}
variable "vpc_name" {
  description = "AWS VPC Name for the Customer VPC"
}
variable "vpc_dhcp_options_id" {
  description = "Custom dhcpoptions id to use."
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.

##### Additional Endpoints Toggle
##### To enable the creation of additional endpoints and route table associations set this value to 'true' on the specific landscape and not on the module level
variable "additional_endpoints_creation" {
  description = "Additional endpoints creation state"
  type        = bool
  default     = false
}

##### Additional Endpoints List
variable "additional_endpoints" {
  description = "Additional interface endpoints"
  type        = list(string)
  default = [
    "backup",
    "backup-gateway",
    # "acm-pca",        # Commercial only
    "cloudtrail",
    # "evidently",        # Commercial only
    # "evidently-dataplane",        # Commercial only
    "monitoring",
    #"rum",        # Commercial only
    # "rum-dataplane",        # Commercial only
    "synthetics",
    # "events",        # Commercial only
    "logs",
    "config",
    # "console",        # Commercial only
    # "signin",        # Commercial only
    # "data_sync",        # Commercial only
    "ds",
    # "dynamodb",       #Gateway endpoint
    "ec2",
    "ec2messages",
    "elasticfilesystem",
    "elasticfilesystem-fips",
    "ecs",
    "ecs-agent",
    "ecs-telemetry",
    "ecr.api",
    "ecr.dkr",
    "elasticfilesystem-fips",
    "kms",
    "logs",
    "monitoring",
    "rds",
    "sns",
    "ssm",
    "ssmmessages",
    "sts",
    # "guardduty-data",        # Commercial only
    # "guardduty-data-fips",        # Commercial only
    "identitystore",
    # "rolesanywhere",        # Commercial only
    "kms",
    "kms-fips",
    "lambda",
    "elasticloadbalancing",
    # "route53",        # Not Real
    #  "ses",        # Not Real
    # "site-to-site_vpn",        # Not Real
    "sns",
    # "events",        # Commercial only
    "ssm",
    # "ssm-contacts",        # Commercial only
    # "ssm-incidents",        # Commercial only
    "ssmmessages",
    # "transitgateway",        # Not Real
    # "vpc",        # Not Real
    # "vpc_flow_logs"        # Not Real
  ]
}


##### Route53
variable "route53_zone_management_id" {
  description = "Management Route53 Hosted ID to associate with"
}

##### Subnet Variables
variable "subnet_production_1a_cidr_block" {
  description = "CIDR block for the production 1a subnet"
}
variable "subnet_production_1b_cidr_block" {
  description = "CIDR block for the production 1b subnet"
}
variable "subnet_production_1c_cidr_block" {
  description = "CIDR block for the production 1b subnet"
}
variable "subnet_quality_assurance_1a_cidr_block" {
  description = "CIDR block for the quality-assurance 1a subnet"
}
variable "subnet_quality_assurance_1b_cidr_block" {
  description = "CIDR block for the quality-assurance 1b subnet"
}
variable "subnet_quality_assurance_1c_cidr_block" {
  description = "CIDR block for the quality-assurance 1c subnet"
}
variable "subnet_development_1a_cidr_block" {
  description = "CIDR block for the development 1a subnet"
}
variable "subnet_development_1b_cidr_block" {
  description = "CIDR block for the development 1b subnet"
}
variable "subnet_development_1c_cidr_block" {
  description = "CIDR block for the development 1c subnet"
}
variable "subnet_edge_1a_cidr_block" {
  description = "CIDR block for the edge 1a subnet"
}
variable "subnet_edge_1b_cidr_block" {
  description = "CIDR block for the edge 1b subnet"
}
variable "subnet_edge_1c_cidr_block" {
  description = "CIDR block for the edge 1c subnet"
}

variable "useZoneD" {
  description = "Use zone D instead of zone C"
  type        = bool
  default     = false
}
variable "custom_no_nat_gateways" {
  description = "Disables the creation of NGWs in the private subnet"
  type        = bool
  default     = false
}
variable "custom_no_local_dns_zone" {
  description = "Use Local Account dns zone"
  type        = bool
  default     = false
}
variable "custom_efs_throughput_mode" {
  description = "Use Local Account EFS throughput mode"
  type        = string
  default     = "provisioned"
}
variable "custom_efs_throughput_in_mibps" {
  description = "Use Local Account EFS throughput in mibps"
  type        = number
  default     = 20
}

##### S3 bucket variables for LCM
variable "bucket_expiration" {
  description = "Enable/Disable customer s3 backup bucket_expiration rule"
  type        = string
  default     = "Disabled"
}

variable "bucket_retention_days" {
  description = "Number of days before objects are deleted from S3 backup bucket"
  type        = number
  default     = 180
}

variable "versioning" {
  description = "Whether versioning is enabled for s3 bucket"
  type        = string
  default     = "Enabled"
}

variable "default_lifecycle_status" {
  description = "Whether default LCM rule is enabled/disabled"
  type        = string
  default     = "Enabled"
}

variable "transition_days_s3ia" {
  description = "Number of days before objects are transitioned to IA"
  type        = number
  default     = 30
}

variable "transition_days_glacier" {
  description = "Number of days before objects are transitioned to glacier"
  type        = number
  default     = 60
}
