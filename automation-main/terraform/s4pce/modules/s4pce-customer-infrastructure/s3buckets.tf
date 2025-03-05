/*
  Description: Creates Customer S3 Buckets
  Comments:
*/


##### Customer Backup
module "context_s3_customer_backups" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  label_order = try(module.base_layer_context.environment_values.kv.cloud_in_country, null) != null ? ["organization", "security_boundary", "cloud_in_country", "business", "customer"] : ["organization", "security_boundary", "business", "customer"]
  name        = "backups"
  description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Backup"
}
module "s3_customer_backups" {
  source     = "../../../shared/modules/aws-s3bucket" # This should point back to the original module.
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  s3_bucket_map = {
    name                     = module.context_s3_customer_backups.name
    versioning               = var.versioning
    default_lifecycle_status = var.default_lifecycle_status
    transition_days_s3ia     = var.transition_days_s3ia
    transition_days_glacier  = var.transition_days_glacier
    bucket_expiration        = var.bucket_expiration
    bucket_retention_days    = var.bucket_retention_days
    restrict_public_buckets  = true # (true|false) AWS Public policy restrictions
    ignore_public_acls       = true # (true|false) AWS Public policy restrictions
    block_public_acls        = true # (true|false) AWS Public policy restrictions
    block_public_policy      = true # (true|false) AWS Public policy restrictions
    tag_name                 = module.context_s3_customer_backups.name
    tag_managedby            = module.context_s3_customer_backups.managed_by
    tag_environment          = module.context_s3_customer_backups.environment
    tag_business             = module.context_s3_customer_backups.business
    tag_customer             = module.context_s3_customer_backups.customer
    tag_description          = module.context_s3_customer_backups.description
    tag_owner                = module.context_s3_customer_backups.owner
  }
  bucket_policy     = "none"
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
##### End Customer Backup
