/*
  Description: Terraform variables
  Comments: N/A
*/

### AWS Variables
variable "aws_region" {
  description = "AWS region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

### SNS and CloudWatch Variables
variable "aws_sns_topic" {
  description = "SNS topic display name"
}

variable "aws_topic_name" {
  description = "AWS SNS topic name"
}

variable "aws_sns_email_distribution_list" {
  description = "Distribution list email address for SNS notifications"
}

variable "aws_sns_ami_restore_email_list" {
  description = "AWS SNS topic email distribution list for ami restores"
}

### PKI Variables
variable "acm_pca_arn" {
  description = "SMS intermediate Certificate Authority"
}

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.

variable "adv_efs_staging_throughput_mode" {
  description = "EFS throughput mode for staging EFS"
  default     = "bursting"
}

variable "adv_efs_staging_provisioned_throughput_in_mibps" {
  description = "EFS provisioned throughput in MiB/s for staging EF when set to provisioned."
  default     = 30
}
