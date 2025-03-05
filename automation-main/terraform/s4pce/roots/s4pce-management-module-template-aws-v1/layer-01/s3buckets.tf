/*
  Description: Handles creation of AWS S3 buckets
  Comments:
    * s3_revocation
    * s3_ssm_patching
    * s3_management_backups
*/

##### S3 Context
module "context_s3_base" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context = module.base_layer_context.context
  # label_order = ["organization", "security_boundary", "business", "cloud_in_country"]
}

##### CRL Revocation
module "context_s3_revocation" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.context_s3_base.context
  name        = "EXAMPLE_TESTING_UNIQUE_revocation"
  description = "S3 bucket to store crl revocation in"
}
module "s3_revocation" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket" # This should point back to the original module.
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  s3_bucket_map = {
    name                    = module.context_s3_revocation.name
    versioning              = "Disabled"
    restrict_public_buckets = false # (true|false) AWS Public policy restrictions
    ignore_public_acls      = false # (true|false) AWS Public policy restrictions
    block_public_acls       = false # (true|false) AWS Public policy restrictions
    block_public_policy     = false # (true|false) AWS Public policy restrictions
    tag_name                = module.context_s3_revocation.name
    tag_managedby           = module.context_s3_revocation.managed_by
    tag_environment         = module.context_s3_revocation.environment
    tag_business            = module.context_s3_revocation.business
    tag_customer            = module.context_s3_revocation.customer
    tag_description         = module.context_s3_revocation.description
    tag_owner               = module.context_s3_revocation.owner
  }
  bucket_policy     = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "acm-pca.amazonaws.com"
            },
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:${module.base_layer_context.partition}:s3:::${module.context_s3_revocation.name}/*",
                "arn:${module.base_layer_context.partition}:s3:::${module.context_s3_revocation.name}"
            ]
        }
    ]
}
POLICY
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
##### End CRL Revocation

##### SSM Patching
module "context_s3_ssm_patching" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.context_s3_base.context
  name        = "EXAMPLE_TESTING_UNIQUE_ssm-patching"
  description = "Patching data maintained by AWS SSM to feed CMDB efforts"
}
module "s3_ssm_patching" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket" # This should point back to the original module.
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  s3_bucket_map = {
    name                    = module.context_s3_ssm_patching.name
    versioning              = "Disabled"
    restrict_public_buckets = true # (true|false) AWS Public policy restrictions
    ignore_public_acls      = true # (true|false) AWS Public policy restrictions
    block_public_acls       = true # (true|false) AWS Public policy restrictions
    block_public_policy     = true # (true|false) AWS Public policy restrictions
    tag_name                = module.context_s3_ssm_patching.name
    tag_managedby           = module.context_s3_ssm_patching.managed_by
    tag_environment         = module.context_s3_ssm_patching.environment
    tag_business            = module.context_s3_ssm_patching.business
    tag_customer            = module.context_s3_ssm_patching.customer
    tag_description         = module.context_s3_ssm_patching.description
    tag_owner               = module.context_s3_ssm_patching.owner
  }
  bucket_policy     = "none"
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
##### End SSM Patching

#### Management Backup
module "context_s3_management_backups" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.context_s3_base.context
  name        = "EXAMPLE_TESTING_UNIQUE_management-backups"
  description = "S3 Bucket for Management VPC backup files"
}
module "s3_management_backups" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-s3bucket" # This should point back to the original module.
  aws_region = module.base_layer_context.region
  build_user = var.build_user
  s3_bucket_map = {
    name                    = module.context_s3_management_backups.name
    versioning              = "Disabled"
    restrict_public_buckets = true # (true|false) AWS Public policy restrictions
    ignore_public_acls      = true # (true|false) AWS Public policy restrictions
    block_public_acls       = true # (true|false) AWS Public policy restrictions
    block_public_policy     = true # (true|false) AWS Public policy restrictions
    tag_name                = module.context_s3_management_backups.name
    tag_managedby           = module.context_s3_management_backups.managed_by
    tag_environment         = module.context_s3_management_backups.environment
    tag_business            = module.context_s3_management_backups.business
    tag_customer            = module.context_s3_management_backups.customer
    tag_description         = module.context_s3_management_backups.description
    tag_owner               = module.context_s3_management_backups.owner
  }
  bucket_policy     = "none"
  module_dependency = join(",", []) # Use this to make the module depend on an external factor
}
#### End Management Backup
