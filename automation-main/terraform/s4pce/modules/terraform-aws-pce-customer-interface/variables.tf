/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/

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
variable "logging_regions" {
  description = "List of regions to support logging in. If not set, only the region the module is deployed in will be configured."
  default     = null
  type        = list(string)
}

##### Interface Bucket Variables
variable "bucket_name" {
  description = "Globally unique name of the bucket (Standard AWS Restrictions apply)"
  type        = string
}
variable "interface_bucket_write_arns" {
  description = "A list of ARNs to be permitted write access to the interface S3 bucket"
  type        = list(string)
  default     = []
}
variable "customer_account_id" {
  description = "The account ID of the customer's AWS account (Partion/Region must match)"
  type        = string
  default     = null
}
variable "customer_bucket_names" {
  description = "The name of the customer bucket to replicate object to.  Pass empty list to disable"
  type        = list(string)
  default     = []
}
variable "shared_kms_key" {
  description = "ARN of the shared KMS key for encrypted replication"
  type        = string
  default     = null
}
variable "delete_marker_replication" {
  description = "Replicate Delete Markers"
  type        = string
  default     = "Enabled"
}
variable "use_service_account" {
  description = "Whether to resources that depend on service account access"
  type        = bool
  default     = false
}
variable "service_account_read_path" {
  description = "Path he service account can read from"
  type        = string
  default     = null
}
variable "service_account_write_path" {
  description = "Path the service account can write to"
  type        = string
  default     = null
}


##### EFS Sync Variables
variable "datasync_s3_subdirectory" {
  description = "Subdirectory of the S3 to datasync. Does not create directory if missing."
  type        = string
  default     = "/datasync"
}
variable "datasync_efs_subdirectory" {
  description = "Subdirectory of the EFS to datasync. Does not create directory if missing."
  type        = string
  default     = "/datasync"
}
variable "destination_efs_mount_target_id" {
  description = "Mount Target to create a datasync destination location to"
  type        = string
}
variable "datasync_schedule_s3_to_efs" {
  description = "Schedule for S3 to EFS Sync (Eventbridge rule). Null for no schedule"
  type        = string
  default     = null
}
variable "datasync_schedule_efs_to_s3" {
  description = "Schedule for EFS to S3 Sync (Eventbridge rule). Null for no schedule"
  type        = string
  default     = null
}
variable "datasync_delete_s3_to_efs" {
  description = "Delete files on EFS that don't exist on S3"
  type        = bool
  default     = false
}
variable "datasync_delete_efs_to_s3" {
  description = "Delete files on S3 that don't exist on EFS"
  type        = bool
  default     = false
}
variable "datasync_efs_destination_subdirectory" {
  description = "Directory on the EFS for datasync to replicate to from S3 if not the same as datasync_efs_subdirectory"
  type        = string
  default     = null
}
variable "datasync_s3_destination_subdirectory" {
  description = "Directory in S3 for datasync to replicate to from EFS if not the same as datasync_s3_subdirectory"
  type        = string
  default     = null
}
