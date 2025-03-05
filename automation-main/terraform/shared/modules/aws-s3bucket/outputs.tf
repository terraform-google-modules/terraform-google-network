/*
  Description: Output of the resulting S3 Bucket creation; Common output attributes of the S3 Bucket
  Comments:
*/

output "bucket_names" { value = aws_s3_bucket.s3_bucket.id }
output "bucket_arn" { value = aws_s3_bucket.s3_bucket.arn }
output "bucket_tags" { value = aws_s3_bucket.s3_bucket.tags }
output "bucket_policies" { value = aws_s3_bucket_policy.s3_bucket }
output "bucket_public_access" { value = aws_s3_bucket_public_access_block.s3_bucket }
