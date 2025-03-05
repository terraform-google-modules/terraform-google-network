/*
  Description: Creates S3 Bucket; Creates AWS S3 Bucket according to input variables.
      A default bucket retention policy is applied, but Terraform does not retention policies
      If a bucket policy is passed in, Terraform WILL enforce bucket policy.  Otherwise terraform will NOT
      enforce bucket policies
  Comments:
    - Due to how terraform and AWS works, it cannot manage retention rules or encryption options for S3 Buckets
*/

##### Module Dependency
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

##### Get AWS Account Metadata
data "aws_caller_identity" "current" {}

##### Generate lists and maps that terraform can understand.
locals {
  bucket_map_actual = {
    bucket_id                                   = var.s3_bucket_map.name
    versioning                                  = lookup(var.s3_bucket_map, "versioning", "Disabled")
    default_lifecycle_status                    = lookup(var.s3_bucket_map, "default_lifecycle_status", "Enabled")
    noncurrent_version_expiration               = lookup(var.s3_bucket_map, "noncurrent_version_expiration", "180")
    noncurrent_version_transition_days          = lookup(var.s3_bucket_map, "noncurrent_version_transition_days", "15")
    noncurrent_version_transition_storage_class = lookup(var.s3_bucket_map, "noncurrent_version_transition_storage_class", "GLACIER")
    transition_days_s3ia                        = lookup(var.s3_bucket_map, "transition_days_s3ia", "30")
    transition_storage_class_s3ia               = lookup(var.s3_bucket_map, "transition_storage_class", "STANDARD_IA")
    transition_days_glacier                     = lookup(var.s3_bucket_map, "transition_days_glacier", "60")
    transition_storage_class_glacier            = lookup(var.s3_bucket_map, "transition_storage_class_glacier", "GLACIER")
    bucket_expiration                           = lookup(var.s3_bucket_map, "bucket_expiration", "Disabled")
    bucket_retention_days                       = lookup(var.s3_bucket_map, "bucket_retention_days", "180")
    restrict_public_buckets                     = lookup(var.s3_bucket_map, "restrict_public_buckets", "true")
    ignore_public_acls                          = lookup(var.s3_bucket_map, "ignore_public_acls", "true")
    block_public_acls                           = lookup(var.s3_bucket_map, "block_public_acls", "true")
    block_public_policy                         = lookup(var.s3_bucket_map, "block_public_policy", "true")
    tag_name                                    = lookup(var.s3_bucket_map, "tag_name", var.s3_bucket_map.name)
    tag_managedby                               = lookup(var.s3_bucket_map, "tag_managedby", "UNTAGGED")
    tag_environment                             = lookup(var.s3_bucket_map, "tag_environment", "UNTAGGED")
    tag_business                                = lookup(var.s3_bucket_map, "tag_business", "UNTAGGED")
    tag_description                             = var.s3_bucket_map.tag_description
    tag_customer                                = lookup(var.s3_bucket_map, "tag_customer", "UNTAGGED")
    tag_owner                                   = lookup(var.s3_bucket_map, "tag_owner", "UNTAGGED")
  }
}

### Create S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.bucket_map_actual.bucket_id

  tags = {
    Name          = local.bucket_map_actual.tag_name
    TerraformName = local.bucket_map_actual.tag_name
    Generated-By  = "terraform"
    Managed-By    = local.bucket_map_actual.tag_managedby
    Environment   = local.bucket_map_actual.tag_environment
    Business      = local.bucket_map_actual.tag_business
    Account       = data.aws_caller_identity.current.account_id
    Description   = local.bucket_map_actual.tag_description
    Customer      = local.bucket_map_actual.tag_customer
    Owner         = local.bucket_map_actual.tag_owner == "UNTAGGED" ? null : local.bucket_map_actual.tag_owner
  }

  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
      force_destroy,
      lifecycle_rule,
      server_side_encryption_configuration
    ]
  }
}

### S3 bucket acl
resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket     = aws_s3_bucket.s3_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket]
}

### S3 bucket ownership
resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

### S3 bucket versioning
resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = local.bucket_map_actual.versioning
  }
}

### Lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    status = local.bucket_map_actual.default_lifecycle_status
    id     = "default"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    noncurrent_version_expiration {
      noncurrent_days = local.bucket_map_actual.noncurrent_version_expiration
    }

    noncurrent_version_transition {
      noncurrent_days = local.bucket_map_actual.noncurrent_version_transition_days
      storage_class   = local.bucket_map_actual.noncurrent_version_transition_storage_class
    }

    transition {
      days          = local.bucket_map_actual.transition_days_s3ia
      storage_class = local.bucket_map_actual.transition_storage_class_s3ia
    }
    transition {
      days          = local.bucket_map_actual.transition_days_glacier
      storage_class = local.bucket_map_actual.transition_storage_class_glacier
    }
  }

  rule {
    id     = "bucket_expiration"
    status = local.bucket_map_actual.bucket_expiration

    expiration {
      days = local.bucket_map_actual.bucket_retention_days
    }
  }
}

### Provision S3 Bucket Policies
resource "aws_s3_bucket_policy" "s3_bucket" {
  count  = var.bucket_policy == "none" ? 0 : 1
  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.bucket_policy

  depends_on = [aws_s3_bucket_public_access_block.s3_bucket]
}

### Public Access block
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  restrict_public_buckets = local.bucket_map_actual.restrict_public_buckets
  ignore_public_acls      = local.bucket_map_actual.ignore_public_acls
  block_public_acls       = local.bucket_map_actual.block_public_acls
  block_public_policy     = local.bucket_map_actual.block_public_policy

  depends_on = [aws_s3_bucket.s3_bucket]
}
