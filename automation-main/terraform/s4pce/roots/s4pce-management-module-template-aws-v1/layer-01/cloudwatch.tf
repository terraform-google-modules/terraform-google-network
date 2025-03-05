/*
  Description: Environment specific configuration for Cloudwatch Logs
  Comments: CloudWatch event rule for health dashboard notifications
*/

module "context_cloudwatch_health_dashboard_event_rule" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "health-dashboard-notifications"
  description = "A CloudWatch Event Rule that triggers on changes in the status of AWS Personal Health Dashboard (AWS Health) and forwards the events to an SNS topic."
}

resource "aws_cloudwatch_event_rule" "health_dashboard" {
  name          = module.context_cloudwatch_health_dashboard_event_rule.name
  description   = module.context_cloudwatch_health_dashboard_event_rule.description
  state         = "ENABLED"
  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Health Event"
  ],
  "source": [
    "aws.health"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "health_dashboard" {
  rule = aws_cloudwatch_event_rule.health_dashboard.name
  arn  = aws_sns_topic.sns_topic.arn
}
