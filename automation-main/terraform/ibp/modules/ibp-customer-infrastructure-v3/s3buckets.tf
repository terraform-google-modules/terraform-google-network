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
      force_destroy,
      lifecycle_rule
    ]
  }
}

resource "aws_s3_bucket_acl" "s3_backups_acl" {
  bucket     = aws_s3_bucket.s3_backups.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_backups]
}

### S3 bucket ownership
resource "aws_s3_bucket_ownership_controls" "s3_backups" {
  bucket = aws_s3_bucket.s3_backups.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "s3_backups_versioning" {
  bucket = aws_s3_bucket.s3_backups.id
  versioning_configuration {
    status = var.backup_versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_backups_lifecycle" {
  bucket     = aws_s3_bucket.s3_backups.id
  depends_on = [aws_s3_bucket_versioning.s3_backups_versioning]

  rule {
    status = var.backup_versioning
    id     = "default"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 15
      storage_class   = "GLACIER"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
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
      force_destroy,
      lifecycle_rule
    ]
  }
}

resource "aws_s3_bucket_acl" "s3_binaries_acl" {
  bucket     = aws_s3_bucket.s3_binaries.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_binaries]
}

### S3 bucket ownership
resource "aws_s3_bucket_ownership_controls" "s3_binaries" {
  bucket = aws_s3_bucket.s3_binaries.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "s3_binaries_versioning" {
  bucket = aws_s3_bucket.s3_binaries.id
  versioning_configuration {
    status = var.binaries_versioning
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_binaries_lifecycle" {
  bucket     = aws_s3_bucket.s3_binaries.id
  depends_on = [aws_s3_bucket_versioning.s3_binaries_versioning]

  rule {
    status = var.binaries_versioning
    id     = "default"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 15
      storage_class   = "GLACIER"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
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
