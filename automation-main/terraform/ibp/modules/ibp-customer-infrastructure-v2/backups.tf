/*
  Description: Handles AWS backup of EC2 instances for both the management and IBP customer VPC
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
  count = var.enable_backup == 1 ? 1 : 0
  name  = "${module.base_layer_context.resource_prefix}-ami-backup"
  rule {
    rule_name         = "${module.base_layer_context.resource_prefix}-ami-backup"
    target_vault_name = aws_backup_vault.main01.name
    schedule          = "cron(0 5 ? * 7 *)" #Backup at midnight on Fridays
    completion_window = 360                 #Complete backups in 6 hours (360 minutes)
    recovery_point_tags = merge(module.base_layer_context.tags, {
      Name            = "${module.base_layer_context.resource_prefix}-ami-backup"
      Description     = "Plan for AMI Backups"
      BackupFrequency = "Weekly at midnight on Fridays"
      BuildUser       = null
      ProvisionDate   = null
    })
    lifecycle {
      cold_storage_after = 0
      delete_after       = 90 # Delete backups after 3 months
    }
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ami-backup-plan"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Plan for AMI Backups")
  })
}

resource "aws_backup_selection" "main01" {
  count        = var.enable_backup == 1 ? 1 : 0
  iam_role_arn = var.management_backup_service_arn
  name         = "ami-backup-selection"
  plan_id      = aws_backup_plan.main01[count.index].id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Customer"
    value = var.customer
  }
}
