/*
 This Terraform `s3backup` file shows how the AWS S3 backup bucket is created when the value of Create_bucket variable is set to either False or True .
Comment:Bucket will be  created, if needed, as a backup to the initial  bucket  in the upper layer.
*/

##### S3 Context
module "context_s3_base" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  label_order = ["organization", "security_boundary", "business"]
}


##### Additional Backup
module "context_s3_additional_backup" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.context_s3_base.context
  name        = "additional-backup-${local.base_context.customer}"
  description = "standby backup bucket if needed"
}

module "s3_additional_backup" {
  count      = var.create_bucket ? 1 : 0
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket" # This should point back to the original module.
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  s3_bucket_map = {
    name                               = module.context_s3_additional_backup.name
    versioning                         = "Disabled" #  Options: (Enabled|Suspended|Disabled)
    restrict_public_buckets            = true       # (true|false) AWS Public policy restrictions
    ignore_public_acls                 = true       # (true|false) AWS Public policy restrictions
    block_public_acls                  = true       # (true|false) AWS Public policy restrictions
    block_public_policy                = true       # (true|false) AWS Public policy restrictions
    noncurrent_version_expiration      = var.noncurrent_version_expiration
    bucket_retention_days              = var.bucket_retention_days
    noncurrent_version_transition_days = var.noncurrent_version_transition_days
    tag_name                           = module.context_s3_additional_backup.name
    tag_managedby                      = module.context_s3_additional_backup.managed_by
    tag_environment                    = module.context_s3_additional_backup.environment
    tag_business                       = module.context_s3_additional_backup.business
    tag_customer                       = module.context_s3_additional_backup.customer
    tag_description                    = module.context_s3_additional_backup.description
    tag_owner                          = module.context_s3_additional_backup.owner

  }
  bucket_policy     = "none"
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
