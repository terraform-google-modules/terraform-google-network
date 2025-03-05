/*
  Description: Terraform main file; Base IAM for S4PCE
  Comments:
*/

##### IAM
module "s4pce_customer_iam" {
  source  = "../../ste-automation/terraform/s4pce/modules/s4pce-customer-iam"
  context = module.base_layer_context.context

  ste_automation_path = "../../ste-automation"

  # S3
  s3_backups_bucket_arn = local.layer_00_outputs.infrastructure.s3_backups.bucket_arn

  # IAM
  iam_role_customer_default_additional_policy_arn = [
    local.management_layer_01_outputs.iam_policy_ec2_ebs.id,
    local.management_layer_01_outputs.iam_policy_ssm_s3_patching.id,
    local.management_layer_01_outputs.iam_policy_acm_pca.id,
    local.management_layer_01_outputs.iam_policy_nessus_agent_install.id
  ]
}

output "iam" { value = module.s4pce_customer_iam }
