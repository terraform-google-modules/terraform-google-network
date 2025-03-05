/*
  Description: Terraform input variables; Variables that should be changed that will be passed to the template module
  Comments:
    - Values should not be specified here.
    - Make appropriate changes in the tfvars file
    - Make additional changes in the main.tf as necessary
*/

##### AWS Variables
variable "aws_region" { default = "us-gov-west-1" } # Set the AWS region
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### S3 Variables
variable "s3_bucket_map" {
  description = "List of S3 Buckets and their settings.  The bucket_policy should be a json."
  type        = map(string)
}
