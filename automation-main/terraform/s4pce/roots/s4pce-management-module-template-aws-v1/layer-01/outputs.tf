/*
  Description: Contains commonly used outputs needed by other modules and dependent automation
  Comments: N/A
*/

##### EFS
output "efs_common_staging" { value = {
  id = aws_efs_file_system.common_staging.id
  ip_address = {
    "1a" = aws_efs_mount_target.common_staging_1a.ip_address
    "1b" = aws_efs_mount_target.common_staging_1b.ip_address
    "1c" = aws_efs_mount_target.common_staging_1c.ip_address
  }
} }


### IAM Policies
output "iam_policy_bastion" { value = {
  id   = aws_iam_policy.bastion_policy.id
  name = aws_iam_policy.bastion_policy.name
} }
output "iam_policy_ec2_ebs" { value = {
  id   = aws_iam_policy.ec2_ebs_policy.id
  name = aws_iam_policy.ec2_ebs_policy.name
} }
output "iam_policy_acm_pca" { value = {
  id   = aws_iam_policy.acm_pca_policy.id
  name = aws_iam_policy.acm_pca_policy.name
} }
output "iam_policy_log_collection_aws" { value = {
  id   = aws_iam_policy.log_collection_aws_policy.id
  name = aws_iam_policy.log_collection_aws_policy.name
} }
output "iam_policy_s3_management_backup_read" { value = {
  id   = aws_iam_policy.s3_management_backup_readlist_policy.id
  name = aws_iam_policy.s3_management_backup_readlist_policy.name
} }
output "iam_policy_s3_management_backup_write" { value = {
  id   = aws_iam_policy.s3_management_backup_write_policy.id
  name = aws_iam_policy.s3_management_backup_write_policy.name
} }
output "iam_policy_ssm_s3_patching" { value = {
  id   = aws_iam_policy.ssm_s3_patching_policy.id
  name = aws_iam_policy.ssm_s3_patching_policy.name
} }
output "iam_policy_ssm_ami_creation" { value = {
  id   = aws_iam_policy.ssm_ami_creation_policy.id
  name = aws_iam_policy.ssm_ami_creation_policy.name
} }

### IAM Roles
output "iam_role_default" { value = {
  instance_profile_name = module.iam_role_default.instance_profile_name
} }
output "iam_role_bastion" { value = {
  instance_profile_name = module.iam_role_bastion.instance_profile_name
} }
output "iam_role_ssm_service_ami_creation" { value = {
  instance_profile_name = module.iam_role_ssm_service_ami_creation.instance_profile_name
} }
output "iam_role_awsbackup" { value = module.iam_role_awsbackup }

### S3 Buckets
output "s3_revocation" { value = {
  arn  = module.s3_revocation.bucket_arn
  name = module.s3_revocation.bucket_names
} }
output "s3_ssm_patching" { value = {
  arn  = module.s3_ssm_patching.bucket_arn
  name = module.s3_ssm_patching.bucket_names
} }
output "s3_management_backups" { value = {
  arn  = module.s3_management_backups.bucket_arn
  name = module.s3_management_backups.bucket_names
} }

### SNS
output "sns_topic" { value = {
  id           = aws_sns_topic.sns_topic.id
  arn          = aws_sns_topic.sns_topic.arn
  display_name = aws_sns_topic.sns_topic.display_name
  name         = aws_sns_topic.sns_topic.name
} }

### SSM
output "ssm_management_rhel_general" { value = {
  patch_group = module.ssm_management_rhel_general.patch_group
} }
output "ssm_management_ubuntu_general" { value = {
  patch_group = module.ssm_management_ubuntu_general.patch_group
} }
output "ssm_management_windows_general" { value = {
  patch_group = module.ssm_management_windows_general.patch_group
} }
output "ssm_customer_rhel_general" { value = {
  patch_group = module.ssm_customer_rhel_general.patch_group
} }
output "ssm_customer_ubuntu_general" { value = {
  patch_group = module.ssm_customer_ubuntu_general.patch_group
} }
output "ssm_customer_windows_general" { value = {
  patch_group = module.ssm_customer_windows_general.patch_group
} }
