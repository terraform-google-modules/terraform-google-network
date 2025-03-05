/*
  Description: Creates Cloudwatch Log for Directory Service
  Comments:
*/

locals {
  cloudwatch_group = var.create_cloudwatch_log_group ? {
    tags = merge(local.tags, {
      meta_name   = var.adv_ds_cloudwatch_log_group_name != "" ? var.adv_ds_cloudwatch_log_group_name : null
      meta_prefix = var.adv_ds_cloudwatch_log_group_name != "" ? null : var.adv_ds_cloudwatch_log_group_name_prefix
    })
    retention       = var.adv_ds_cloudwatch_log_group_retention
    log_group_class = var.adv_ds_cloudwatch_log_group_class
  } : { tags = {}, retention = "", log_group_class = "" }
}
resource "aws_cloudwatch_log_group" "main01" {
  count             = var.create_cloudwatch_log_group ? 1 : 0
  name              = local.cloudwatch_group.tags.meta_name
  name_prefix       = local.cloudwatch_group.tags.meta_prefix
  retention_in_days = var.adv_ds_cloudwatch_log_group_retention
  log_group_class   = var.adv_ds_cloudwatch_log_group_class
  tags              = local.cloudwatch_group.tags
}
resource "aws_directory_service_log_subscription" "main01" {
  count          = var.create_cloudwatch_log_group ? 1 : 0
  directory_id   = aws_directory_service_directory.main01.id
  log_group_name = aws_cloudwatch_log_group.main01[0].name
}

output "cloudwatch_log_group" { value = var.create_cloudwatch_log_group ? {
  meta_name = aws_cloudwatch_log_group.main01[0].name
  arn       = aws_cloudwatch_log_group.main01[0].arn
  id        = aws_cloudwatch_log_group.main01[0].id
} : null }
