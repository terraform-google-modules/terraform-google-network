/*
  Description: Creates 2 buckets for each customer; Creates buckets named ibp-customer##-backups and ibp-customer##-binaries for each customer.
  Comments:
*/

##### Creating s3_backups bucket
### Create Random Name
resource "random_id" "s3_backups" {
  prefix      = "${var.vpc_custom_name}-backups-"
  byte_length = 8
}

### Create S3 bucket
resource "aws_s3_bucket" "s3_backups" {
  bucket = random_id.s3_backups.hex
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    id                                     = "default"
    tags                                   = {}

    noncurrent_version_expiration {
      days = 90
    }

    noncurrent_version_transition {
      days          = 15
      storage_class = "GLACIER"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name          = random_id.s3_backups.hex
    TerraformName = random_id.s3_backups.hex
    Generated-By  = "terraform"
    Managed-By    = "untagged"
    Environment   = "untagged"
    Business      = "ibp"
    Account       = data.aws_caller_identity.current.account_id
    Description   = "backups for ${var.vpc_custom_name}"
    Customer      = var.vpc_custom_name
  }

  lifecycle {
    ignore_changes = [
      tags,
      lifecycle_rule
    ]
  }
}

### Provision S3 Bucket Policies
resource "aws_s3_bucket_public_access_block" "s3_backups" {
  bucket                  = aws_s3_bucket.s3_backups.id
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}
##### END s3_backups bucket


##### Creating s3_binaries bucket
### Create Random Name
resource "random_id" "s3_binaries" {
  prefix      = "${var.vpc_custom_name}-binaries-"
  byte_length = 8
}

### Create S3 bucket
resource "aws_s3_bucket" "s3_binaries" {
  bucket = random_id.s3_binaries.hex
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  lifecycle_rule {
    abort_incomplete_multipart_upload_days = 0
    enabled                                = true
    id                                     = "default"
    tags                                   = {}

    noncurrent_version_expiration {
      days = 90
    }

    noncurrent_version_transition {
      days          = 15
      storage_class = "GLACIER"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name          = random_id.s3_binaries.hex
    TerraformName = random_id.s3_binaries.hex
    Generated-By  = "terraform"
    Managed-By    = "untagged"
    Environment   = "untagged"
    Business      = "ibp"
    Account       = data.aws_caller_identity.current.account_id
    Description   = "Backups for ${var.vpc_custom_name}"
    Customer      = var.vpc_custom_name
  }

  lifecycle {
    ignore_changes = [
      tags,
      lifecycle_rule
    ]
  }
}

### Provision S3 Bucket Policies
resource "aws_s3_bucket_public_access_block" "s3_binaries" {
  bucket                  = aws_s3_bucket.s3_binaries.id
  restrict_public_buckets = true
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
}
##### END s3_binaries bucket
