/*
  Description: Terraform input variables; Variables for the S3 Bucket Module
  Comments:
    - Values should not be specified here.
    - Make appropriate changes in the tfvars file
    - Make additional changes in the main.tf as necessary
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS region to run in"
}

variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### S3 Variables
variable "s3_bucket_map" {
  description = "List of S3 Buckets and their settings.  The bucket_policy should be a json."
  type        = map(string)
  // default = {
  //   name = "test-louis-bucket1"
  //   versioning = Disabled
  //   restrict_public_buckets = true
  //   ignore_public_acls      = true
  //   block_public_acls       = true
  //   block_public_policy     = true
  // }
}

variable "bucket_policy" {
  description = "JSON Bucket Policy. Specify 'none' for no policy"
  default     = "none"
}

variable "module_dependency" {
  default = ""
}
