/*
  Description: Test the module
  Comments: N/A
*/

# ##### Documentation of module inputs
# module "bucket_replication" {
#   source = "../../../modules/terraform-aws-pce-customer-interface"
#   context                           = (required) Null Context passed in for tagging
#   interface_bucket_write_arns       = (required) (List) A list of ARNs to be permitted write access to the interface S3 bucket
#   bucket_name                       = (required) (String) Globally unique name of the bucket (Standard AWS Restrictions apply)
#   customer_account_id               = (required) (String) The account ID of the customer's AWS account (Partion/Region must match)
#   customer_bucket_names             = (required) (List) The name of the customer bucket to replicate object to.  Pass empty list to disable
#   destination_efs_mount_target_id   = (required) (String) Mount Target to create a datasync destination location to
#   schedule_expression               = (optional) (String) Schedule for S3 to EFS Sync (Eventbridge rule) Defaults to 15 minutes
#   s3_subdirectory                   = (optional) (String) Subdirectory of the S3 bucket to replicate from
#   efs_subdirectory                  = (optional) (String) Subdirectory of the EFS to write to.  Must already exist Defaults to root folder
# }

module "bucket_replication" {
  source                          = "../../../../modules/terraform-aws-pce-customer-interface"
  context                         = module.base_context.context
  interface_bucket_write_arns     = []
  bucket_name                     = module.base_context.bucket_salted
  customer_account_id             = module.base_context.account_id
  customer_bucket_names           = []
  destination_efs_mount_target_id = data.terraform_remote_state.layer_00.outputs.test_efs.mount_id
  ### Optional values below
  shared_kms_key              = null
  datasync_efs_subdirectory   = "/interface"
  datasync_s3_subdirectory    = "/"
  datasync_schedule_s3_to_efs = "rate(20 minutes)"
  datasync_schedule_efs_to_s3 = "cron(15,45 * * * ? *)"
  datasync_delete_s3_to_efs   = false
  datasync_delete_efs_to_s3   = true
}
