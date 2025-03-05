/*
  Description: Handles AWS backup of EC2 instances for the S4 PCE management customer
  Comments:
*/


data "aws_kms_alias" "ec2_backups" {
  name = "alias/aws/backup"
}

resource "aws_backup_vault" "main01" {
  name        = "${module.base_layer_context.resource_prefix}-ami-backup-vault"
  kms_key_arn = data.aws_kms_alias.ec2_backups.target_key_arn
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ami-backup-vault"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} ami backup vault")
  })
}

resource "aws_backup_plan" "main01" {
  name = "${module.base_layer_context.resource_prefix}-ami-backup"
  rule {
    rule_name         = "${module.base_layer_context.resource_prefix}-ami-backup"
    target_vault_name = aws_backup_vault.main01.name
    schedule          = var.backup_metadata.schedule
    completion_window = var.backup_metadata.completion_window
    recovery_point_tags = merge(module.base_layer_context.tags, {
      Name            = "${module.base_layer_context.resource_prefix}-ami-backup"
      Description     = "Plan for AMI Backups"
      BackupFrequency = var.backup_metadata.frequency_description
      BuildUser       = null
      ProvisionDate   = null
    })
    lifecycle {
      delete_after = var.backup_metadata.delete_after
    }
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ami-backup-plan"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Plan for AMI Backups")
  })
}

resource "aws_backup_selection" "main01" {
  iam_role_arn = local.layer_01_outputs.iam_role_awsbackup.role_arn
  name         = coalesce(var.backup_metadata.selection_name, "${module.base_layer_context.resource_prefix}-ami-backup-selection")
  plan_id      = aws_backup_plan.main01.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Customer"
    value = module.base_layer_context.customer
  }
}
