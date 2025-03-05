/*
  Description: Schedules the datasync replication
*/

### S3 to EFS
data "archive_file" "customer_interface_to_efs" {
  for_each                = var.datasync_schedule_s3_to_efs == null ? toset([]) : toset(["s3_to_efs"])
  type                    = "zip"
  source_content_filename = "lambda-start-datasync.py"
  source_content = templatefile("${path.module}/lambda-start-datasync.tftpl", {
    region   = module.base_layer_context.region,
    task_arn = aws_datasync_task.customer_interface_to_efs.id
  })
  output_path = "/tmp/lambda-start-datasync_to_efs.zip"
}
resource "aws_lambda_function" "customer_interface_to_efs" {
  for_each         = var.datasync_schedule_s3_to_efs == null ? toset([]) : toset(["s3_to_efs"])
  depends_on       = [data.archive_file.customer_interface_to_efs["s3_to_efs"]]
  function_name    = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  role             = aws_iam_role.interface_s3_replication.arn
  filename         = data.archive_file.customer_interface_to_efs["s3_to_efs"].output_path
  source_code_hash = data.archive_file.customer_interface_to_efs["s3_to_efs"].output_base64sha256
  runtime          = "python3.9"
  handler          = "lambda-start-datasync.lambda_handler"
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  })
}
resource "aws_cloudwatch_event_rule" "customer_interface_to_efs" {
  for_each            = var.datasync_schedule_s3_to_efs == null ? toset([]) : toset(["s3_to_efs"])
  depends_on          = [aws_iam_role_policy_attachment.interface_datasync_lambda]
  name                = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  description         = module.context_datasync.description
  schedule_expression = var.datasync_schedule_s3_to_efs
  is_enabled          = true
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-efs"
  })
}
resource "aws_lambda_permission" "customer_interface_to_efs" {
  for_each      = var.datasync_schedule_s3_to_efs == null ? toset([]) : toset(["s3_to_efs"])
  statement_id  = "eventrule_${aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].id}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.customer_interface_to_efs["s3_to_efs"].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].arn
}
resource "aws_cloudwatch_event_target" "customer_interface_to_efs" {
  for_each   = var.datasync_schedule_s3_to_efs == null ? toset([]) : toset(["s3_to_efs"])
  depends_on = [aws_lambda_permission.customer_interface_to_efs["s3_to_efs"]]
  rule       = aws_cloudwatch_event_rule.customer_interface_to_efs["s3_to_efs"].name
  arn        = aws_lambda_function.customer_interface_to_efs["s3_to_efs"].arn
}
### End S3 to EFS

### EFS to S3
data "archive_file" "customer_interface_to_s3" {
  for_each                = var.datasync_schedule_efs_to_s3 == null ? toset([]) : toset(["efs_to_s3"])
  type                    = "zip"
  source_content_filename = "lambda-start-datasync.py"
  source_content = templatefile("${path.module}/lambda-start-datasync.tftpl", {
    region   = module.base_layer_context.region,
    task_arn = aws_datasync_task.customer_interface_to_s3.id
  })
  output_path = "/tmp/lambda-start-datasync_to_s3.zip"
}
resource "aws_lambda_function" "customer_interface_to_s3" {
  for_each         = var.datasync_schedule_efs_to_s3 == null ? toset([]) : toset(["efs_to_s3"])
  depends_on       = [data.archive_file.customer_interface_to_s3["efs_to_s3"]]
  function_name    = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  role             = aws_iam_role.interface_s3_replication.arn
  filename         = data.archive_file.customer_interface_to_s3["efs_to_s3"].output_path
  source_code_hash = data.archive_file.customer_interface_to_s3["efs_to_s3"].output_base64sha256
  runtime          = "python3.9"
  handler          = "lambda-start-datasync.lambda_handler"
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  })
}
resource "aws_cloudwatch_event_rule" "customer_interface_to_s3" {
  for_each            = var.datasync_schedule_efs_to_s3 == null ? toset([]) : toset(["efs_to_s3"])
  depends_on          = [aws_iam_role_policy_attachment.interface_datasync_lambda]
  name                = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  description         = module.context_datasync.description
  schedule_expression = var.datasync_schedule_efs_to_s3
  is_enabled          = true
  tags = merge(module.context_datasync.tags, {
    Name = "${module.context_datasync.resource_prefix}-datasync-to-s3"
  })
}
resource "aws_lambda_permission" "customer_interface_to_s3" {
  for_each      = var.datasync_schedule_efs_to_s3 == null ? toset([]) : toset(["efs_to_s3"])
  statement_id  = "eventrule_${aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].id}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.customer_interface_to_s3["efs_to_s3"].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].arn
}
resource "aws_cloudwatch_event_target" "customer_interface_to_s3" {
  for_each   = var.datasync_schedule_efs_to_s3 == null ? toset([]) : toset(["efs_to_s3"])
  depends_on = [aws_lambda_permission.customer_interface_to_s3["efs_to_s3"]]
  rule       = aws_cloudwatch_event_rule.customer_interface_to_s3["efs_to_s3"].name
  arn        = aws_lambda_function.customer_interface_to_s3["efs_to_s3"].arn
}
### End EFS to S3
