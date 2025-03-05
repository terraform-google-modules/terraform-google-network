/*
  Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
  Layer: 00
  Comments: N/A
*/

##### S3
output "customer_interface_bucket" { value = {
  id            = aws_s3_bucket.customer_interface.id
  arn           = aws_s3_bucket.customer_interface.arn
  tags          = aws_s3_bucket.customer_interface.tags
  public_access = aws_s3_bucket_public_access_block.customer_interface
} }


output "customer_interface_datasync" { value = {
  s3_location = {
    id            = aws_datasync_location_s3.customer_interface.id
    s3_bucket_arn = aws_datasync_location_s3.customer_interface.s3_bucket_arn
    subdirectory  = aws_datasync_location_s3.customer_interface.subdirectory
  }
  efs_location = {
    id                  = aws_datasync_location_efs.customer_interface.id
    efs_file_system_arn = aws_datasync_location_efs.customer_interface.efs_file_system_arn
    subdirectory        = aws_datasync_location_efs.customer_interface.subdirectory
  }
  s3_to_efs_replication = var.datasync_schedule_s3_to_efs == null ? null : {
    id                     = aws_datasync_task.customer_interface_to_efs.id
    preserve_deleted_files = aws_datasync_task.customer_interface_to_efs.options[0].preserve_deleted_files
    schedule = {
      arn                 = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].arn
      id                  = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].id
      is_enabled          = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].is_enabled
      schedule_expression = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].schedule_expression
  } }
  efs_to_s3_replication = var.datasync_schedule_efs_to_s3 == null ? null : {
    id                     = aws_datasync_task.customer_interface_to_s3.id
    preserve_deleted_files = aws_datasync_task.customer_interface_to_s3.options[0].preserve_deleted_files
    schedule = {
      arn                 = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].arn
      id                  = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].id
      is_enabled          = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].is_enabled
      schedule_expression = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].schedule_expression
  } }
} }
