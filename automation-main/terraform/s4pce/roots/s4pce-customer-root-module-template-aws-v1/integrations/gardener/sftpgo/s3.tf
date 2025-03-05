/*
  Description: Handles creation of a S3 bucket dedicated for use by SFTPGo & S3 File Gateway
  Comments:
    - This bucket should not be used for anything other than SFTPGo or the related S3 File Gateway
    - This bucket is ALWAYS created, regardless of whether or not the 's3fgw_s3_bucket_arn_override' variable is set
*/

##### SFTPGo Bucket Creation
### Bucket
resource "aws_s3_bucket" "sftpgo" {
  bucket_prefix = "${local.layer_resource_prefix}-"
  force_destroy = false

  lifecycle {
    ignore_changes = [
      force_destroy,
    ]
  }
}
### SSE Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "sftpgo" {
  bucket = aws_s3_bucket.sftpgo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
### Ownership Controls
resource "aws_s3_bucket_ownership_controls" "sftpgo" {
  bucket = aws_s3_bucket.sftpgo.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
### ACL
resource "aws_s3_bucket_acl" "sftpgo" {
  depends_on = [aws_s3_bucket_ownership_controls.sftpgo] # NOTE: Hard dependency, particularly with "BucketOwnerPreferred"

  bucket = aws_s3_bucket.sftpgo.id
  acl    = "private"
}
### Versioning
resource "aws_s3_bucket_versioning" "sftpgo" {
  bucket = aws_s3_bucket.sftpgo.id
  versioning_configuration {
    status = "Enabled"
  }
}

##### Outputs
output "aws_s3_bucket_sftpgo" {
  value = {
    id  = aws_s3_bucket.sftpgo.id
    arn = aws_s3_bucket.sftpgo.arn
  }
}
