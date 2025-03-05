/*
  Description: Test the module
  Comments:
*/

##### IAM
module "s4pce_customer_iam" {
  source  = "../"
  context = module.base_context.context

  ste_automation_path = "../../../../../"

  # S3
  s3_backups_bucket_arn = aws_s3_bucket.test.arn

  # IAM
  iam_role_customer_default_additional_policy_arn = []
}

output "iam" { value = module.s4pce_customer_iam }
