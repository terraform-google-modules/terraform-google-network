/*
  Description: Environment specific SNS topic and subscription; Creates SNS topic and subscription
  Comments:
*/

resource "aws_sns_topic" "sns_topic" {
  name            = var.aws_topic_name
  display_name    = var.aws_sns_topic
  policy          = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Resource": "arn:${module.base_layer_context.partition}:sns:${module.base_layer_context.region}:${data.aws_caller_identity.current.account_id}:${var.aws_topic_name}",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "${data.aws_caller_identity.current.account_id}"
        }
      }
    }
  ]
}
EOF
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF
}

resource "aws_sns_topic_subscription" "main_distribution_list" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.aws_sns_email_distribution_list
}

resource "aws_sns_topic" "ami_restore" {
  name         = "EXAMPLE_TESTING_UNIQUE_ami-restore"
  display_name = "EXAMPLE_TESTING_UNIQUE_ami-restore"
  tags = merge(module.base_layer_context.tags, {
    Name        = "ami-restore"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name}-ami-restore")
  })
}

resource "aws_sns_topic_subscription" "ami_restore" {
  for_each  = toset(var.aws_sns_ami_restore_email_list)
  topic_arn = aws_sns_topic.ami_restore.arn
  protocol  = "email"
  endpoint  = each.value
}
