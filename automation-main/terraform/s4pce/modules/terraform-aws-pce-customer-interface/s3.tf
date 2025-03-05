/*
  Description: Handles S3 related resources.
*/

## customer_interface
module "context_s3_customer_interface" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  flags       = { override_name = true }
  name        = var.bucket_name
  description = "S3 bucket used to replicate content to interface EFS and ${module.base_layer_context.customer} bucket"
}

locals {
  interface_bucket_write_access_arns = sort(flatten([
    "arn:${module.base_layer_context.partition}:iam::${module.base_layer_context.account_id}:root",
    var.interface_bucket_write_arns
  ]))
}

resource "aws_s3_bucket" "customer_interface" {
  tags   = module.context_s3_customer_interface.tags
  bucket = module.context_s3_customer_interface.name
  lifecycle {
    ignore_changes = [
      force_destroy,
      lifecycle_rule,
      server_side_encryption_configuration,
      replication_configuration
    ]
  }
}

resource "aws_s3_bucket_ownership_controls" "customer_interface" {
  bucket = aws_s3_bucket.customer_interface.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "customer_interface" {
  bucket     = aws_s3_bucket.customer_interface.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.customer_interface]
}

resource "aws_s3_bucket_versioning" "customer_interface" {
  bucket = aws_s3_bucket.customer_interface.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "customer_interface" {
  for_each = toset(var.customer_bucket_names)
  # Note: Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.customer_interface]

  role   = aws_iam_role.interface_s3_replication.arn
  bucket = aws_s3_bucket.customer_interface.id

  rule {
    # Note: delete_marker_replication requires filter not prefix
    filter {}
    priority = 1
    id       = module.context_s3_customer_interface.name
    status   = "Enabled"
    delete_marker_replication { status = var.delete_marker_replication }
    dynamic "source_selection_criteria" {
      for_each = var.shared_kms_key == null ? [] : [var.shared_kms_key]
      content {
        sse_kms_encrypted_objects { status = "Enabled" }
      }
    }
    destination {
      bucket  = "arn:${module.base_layer_context.partition}:s3:::${each.value}"
      account = var.customer_account_id
      access_control_translation {
        owner = "Destination"
      }
      dynamic "encryption_configuration" {
        for_each = var.shared_kms_key == null ? [] : [var.shared_kms_key]
        content {
          replica_kms_key_id = var.shared_kms_key
        }
      }
    }
  }
}

resource "aws_s3_bucket_policy" "customer_interface" {
  bucket = aws_s3_bucket.customer_interface.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ProductsReadWrite",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : local.interface_bucket_write_access_arns
        },
        "Action" : [
          "s3:GetBucketVersioning",
          "s3:PutBucketVersioning",
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ObjectOwnerOverrideToBucketOwner",
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:${module.base_layer_context.partition}:s3:::${module.context_s3_customer_interface.name}",
          "arn:${module.base_layer_context.partition}:s3:::${module.context_s3_customer_interface.name}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "customer_interface" {
  bucket                  = aws_s3_bucket.customer_interface.id
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true

  depends_on = [aws_s3_bucket.customer_interface]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "customer_interface" {
  bucket = aws_s3_bucket.customer_interface.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.shared_kms_key == null ? "AES256" : "aws:kms"
    }
    bucket_key_enabled = true
  }
}
## End customer_interface
