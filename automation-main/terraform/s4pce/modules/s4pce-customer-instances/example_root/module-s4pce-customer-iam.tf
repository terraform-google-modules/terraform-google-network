/*
  Description: Create the S4PCE IAM
  Comments:
*/

##### IAM
module "s4pce_customer_iam" {
  source  = "../../s4pce-customer-iam"
  context = module.base_context.context

  ste_automation_path = "../../../../../"

  # S3
  s3_backups_bucket_arn = module.s4pce_customer_infrastructure.s3_backups.bucket_arn

  # IAM
  iam_role_customer_default_additional_policy_arn = []

  depends_on = [module.s4pce_customer_infrastructure]
}

output "iam" { value = module.s4pce_customer_iam }
