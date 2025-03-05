/*
  Description: Terraform input variables
  Comments:
    Requires null context
*/

##### S3
variable "s3_backups_bucket_arn" {
  description = "The PCE Customer S3 backups bucket ARN."
  type        = string
}

##### Paths
variable "ste_automation_path" {
  description = "The path to the ste-automation repository. Used to supply policy templates"

}

##### IAM
variable "iam_role_customer_default_additional_policy_arn" {
  description = "list of additional policy ARNs to add to the customer default IAM role"
  type        = list(string)
  default     = []
}