/*
  Description: Terraform input variables
*/

variable "s3_bucket_name" {
  description = "Name of the AWS S3 bucket"
  type        = string
}

variable "folder_path" {
  description = "(Optional) Path to folder within the AWS S3 bucket to look for a list of Terraform Workspaces"
  type        = string
  default     = null
}
