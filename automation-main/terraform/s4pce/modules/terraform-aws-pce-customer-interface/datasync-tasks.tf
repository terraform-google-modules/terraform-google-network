/*
  Description: Creates datasync replication tasks
*/

module "context_datasync" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "datasync"
  description = "${module.base_layer_context.customer} S3 to EFS Datasync"
}

### Datasync S3 location
resource "aws_datasync_location_s3" "customer_interface" {
  depends_on    = [aws_iam_role_policy_attachment.interface_datasync_s3]
  s3_bucket_arn = aws_s3_bucket.customer_interface.arn
  subdirectory  = var.datasync_s3_subdirectory
  s3_config {
    bucket_access_role_arn = aws_iam_role.interface_s3_replication.arn
  }
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-s3"
  })
}
### End Datasync S3 location

### Datasync EFS location
data "aws_efs_mount_target" "customer_interface" {
  mount_target_id = var.destination_efs_mount_target_id
}
data "aws_security_group" "customer_interface" {
  for_each = data.aws_efs_mount_target.customer_interface.security_groups
  id       = each.value
}
data "aws_subnet" "customer_interface" {
  id = data.aws_efs_mount_target.customer_interface.subnet_id
}
locals {
  security_group_arns = [
    for key, value in data.aws_security_group.customer_interface : value.arn
  ]
}
resource "aws_datasync_location_efs" "customer_interface" {
  efs_file_system_arn = data.aws_efs_mount_target.customer_interface.file_system_arn
  subdirectory        = var.datasync_efs_subdirectory
  ec2_config {
    security_group_arns = local.security_group_arns
    subnet_arn          = data.aws_subnet.customer_interface.arn
  }
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-efs"
  })
}
### End Datasync EFS location

### Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "customer_interface_to_efs" {
  name = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  })
}
resource "aws_cloudwatch_log_group" "customer_interface_to_s3" {
  name = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  })
}
### End Cloudwatch Log Group


### Datasync Task
resource "aws_datasync_task" "customer_interface_to_efs" {
  source_location_arn      = aws_datasync_location_s3.customer_interface.arn
  destination_location_arn = aws_datasync_location_efs.customer_interface.arn
  name                     = module.context_datasync.name
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.customer_interface_to_efs.arn
  options {
    preserve_deleted_files = var.datasync_delete_s3_to_efs == true ? "REMOVE" : "PRESERVE"
    log_level              = "TRANSFER"
  }
  excludes {
    filter_type = var.datasync_s3_destination_subdirectory != null ? "SIMPLE_PATTERN" : null
    value       = var.datasync_s3_destination_subdirectory != null ? var.datasync_s3_destination_subdirectory : null
  }
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  })
}
resource "aws_datasync_task" "customer_interface_to_s3" {
  source_location_arn      = aws_datasync_location_efs.customer_interface.arn
  destination_location_arn = aws_datasync_location_s3.customer_interface.arn
  name                     = module.context_datasync.name
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.customer_interface_to_s3.arn
  options {
    preserve_deleted_files = var.datasync_delete_efs_to_s3 == true ? "REMOVE" : "PRESERVE"
    log_level              = "TRANSFER"
  }
  excludes {
    filter_type = var.datasync_efs_destination_subdirectory != null ? "SIMPLE_PATTERN" : null
    value       = var.datasync_efs_destination_subdirectory != null ? var.datasync_efs_destination_subdirectory : null
  }
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  })
}
### End Datasync Task
