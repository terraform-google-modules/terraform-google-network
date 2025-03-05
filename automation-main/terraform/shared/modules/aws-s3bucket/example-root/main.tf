/*
  Description: Terraform main file; This shows how to integrate the aws-s3bucket module into a root module
  Comments:
    - Each s3 bucket must be specified as seperate module calls in the root module
*/

##### Example S3 Bucket Module Call
module "s3_testbucket1" {
  source            = "../../aws-s3bucket" # This should point back to the original module.
  aws_region        = var.aws_region
  build_user        = var.build_user
  s3_bucket_map     = var.s3_bucket_map
  bucket_policy     = "none"
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
