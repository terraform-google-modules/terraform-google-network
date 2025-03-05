/*
  Description: Handles AWS account IAM roles
  Comments:
    * iam_role_bastion
    * iam_role_default
    * iam_role_ssm_service_ami_creation
    * iam_role_awsbackup
*/

###### Roles
module "context_iam_role_default" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "default"
  description = "Default IAM Profile"
}
module "iam_role_default" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = module.context_iam_role_default.name
  iam_role_description = module.context_iam_role_default.description
  iam_policy_arn_list = [
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.s3_management_backup_readlist_policy.arn,
    aws_iam_policy.s3_management_backup_write_policy.arn,
    aws_iam_policy.ssm_s3_patching_policy.arn,
    aws_iam_policy.ec2_ebs_policy.arn,
    aws_iam_policy.acm_pca_policy.arn,
    # aws_iam_policy.nessus_agent_install_policy.arn   ##removed as currently out of scope
  ]
  iam_instance_profile_name = module.context_iam_role_default.name
  tag_managedby             = module.context_iam_role_default.managed_by
  build_user                = module.context_iam_role_default.build_user
  assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
  module_dependency         = join(",", [])
}

module "context_iam_role_bastion" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "bastion"
  description = "Bastion IAM Profile"
}
module "iam_role_bastion" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = module.context_iam_role_bastion.name
  iam_role_description = module.context_iam_role_bastion.description
  iam_policy_arn_list = [
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores",
    aws_iam_policy.ssm_s3_patching_policy.arn,
    aws_iam_policy.s3_management_backup_readlist_policy.arn,
    aws_iam_policy.ec2_ebs_policy.arn,
    aws_iam_policy.bastion_policy.arn,
    aws_iam_policy.acm_pca_policy.arn,
    # aws_iam_policy.nessus_agent_install_policy.arn,  ##removed as currently out of scope
    aws_iam_policy.iam_passrole_policy.arn,
    aws_iam_policy.sns_topic_policy.arn
  ]
  iam_instance_profile_name = module.context_iam_role_bastion.name
  tag_managedby             = module.base_layer_context.managed_by
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("../templates/iam/trust/ec2-role-trust-policy.json")
  module_dependency         = join(",", [])
}

module "iam_role_ssm_service_ami_creation" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/aws-iam-role"
  iam_role_name        = "${module.base_layer_context.resource_prefix}-ssm-service-role-ami-creation"
  iam_role_description = "Provides AWS SSM permissions to create online AMI backups of EC2 instances."
  iam_policy_arn_list = [
    aws_iam_policy.ssm_ami_creation_policy.arn
  ]
  iam_instance_profile_name = ""
  tag_managedby             = module.base_layer_context.managed_by
  build_user                = module.base_layer_context.build_user
  assume_role_policy        = file("../templates/iam/trust/ssm-role-trust-policy.json")
  module_dependency         = join(",", [])
}

module "iam_role_awsbackup" {
  source               = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-context-aws-iam-role"
  context              = module.base_layer_context.context
  iam_role_name        = lower("${module.base_layer_context.resource_prefix}-AWSBackupService")
  iam_role_description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} AWS Backup Service")
  iam_role_path        = "/service-role/"
  iam_policy_arn_list = [
    "arn:${module.base_layer_context.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:${module.base_layer_context.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores",
  ]
  iam_instance_profile_name = ""
  assume_role_policy        = file("../templates/iam/trust/aws-backup-service-trust-policy.json")
}
