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

##### SFTPGo (RDS) Database Variables
variable "sftpgo_db_master_username" {
  description = "The master username for the SFTPGo database."
  type        = string
  default     = "svc_aws_rds_postgres"
}
variable "sftpgo_db_master_user_password" {
  description = "The master user password for the SFTPGo database. [!] This is intended to be rotated by operators after initial setup"
  type        = string
}
variable "sftpgo_db_apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = false
}

##### S3 File Gateway (for SFTPGo) Variables
variable "sftpgo_s3fgw_allowed_clients" {
  description = "Range of IPs allowed to access the SFTPGo S3 file gateway share"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "sftpgo_s3fgw_s3_bucket_arn_override" {
  description = "Optionally override the ARN of the S3 bucket to use for the SFTPGo storage gateway; it will be used instead of the bucket created in this integration"
  type        = string
  default     = ""
}
variable "sftpgo_s3fgw_sgw_instance_type" {
  description = "The EC2 instance type to use for the storage gateway instance"
  type        = string
  default     = "c6in.4xlarge"
}
variable "sftpgo_s3fgw_cache_block_device" {
  description = "Customize details about the additional (cache) block device of the storage gateway instance"
  type        = map(any)
  default = {
    disk_size   = 150
    volume_type = "gp3"
  }
}
variable "sftpgo_s3fgw_sgw_timezone" {
  description = "Timezone for the storage gateway. Useful for scheduling snapshots, configuring maintenance schedules, etc."
  type        = string
  default     = "GMT-5:00"
}
variable "sftpgo_s3fgw_nfs_kms_key_arn" {
  description = "KMS key arn to use for encrypthing the storage gateway NFS file share"
  type        = string
  default     = ""
}
