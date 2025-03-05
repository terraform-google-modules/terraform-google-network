/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### Access Point Variables
# Note: the following values are optional when set to null: posix_user, root_directory, creation_info
variable "access_points" {
  description = "Access Point Configuration"
  type = map(object({
    posix_user = object({
      uid = number
      gid = number
    })
    root_directory = object({
      path = string
      creation_info = object({
        owner_gid   = number
        owner_uid   = number
        permissions = number
      })
    })
  }))
}


##### Interface Bucket Variables
variable "interface_bucket_write_arns" {
  description = "A list of ARNs to be permitted write access to the interface S3 bucket"
}
variable "customer_account_id" {
  description = "The account ID of the customer's AWS gov-cloud account"
}
variable "customer_bucket_names" {
  description = "The name of the customer buckets for each landscape to replicate objects to"
}
variable "shared_kms_key" {
  description = "ARN of the key to encrypt outgoing replication"
  type        = string
  default     = null
}
