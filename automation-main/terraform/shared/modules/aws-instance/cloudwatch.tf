/*
  Description: Creates a cloudwatch hardware autorecovery monitor
  Input Triggers:
    - enable_state_recovery : String value. A value of "true" will trigger this file.
  Description: When triggered, this file will create a cloudwatch alarm based on instance state.
    On failure, the alarm will attempt to migrate the hardware and reboot the instance.
  Comments:
*/

locals {
  _alarm_action = ["arn:${data.aws_partition.current.partition}:automate:${local.context_passed ? module.module_context[0].region : var.aws_region}:ec2:recover"]
  # EC2 recovery action current not support for i3 instance types in the following regions
  _ignore_regions      = ["ap-southeast-2", "ca-central-1", "eu-west-2", "us-east-2"]
  _condition_1         = substr(split(".", var.instance_type)[0], 0, 2) == "i3" // account for i3/i3en/i3* variations
  _condition_2         = data.aws_partition.current.partition == "aws"
  _condition_3         = contains(local._ignore_regions, data.aws_region.current.name)
  _ignore_alarm_action = local._condition_1 && local._condition_2 && local._condition_3
  alarm_actions        = local._ignore_alarm_action ? [] : local._alarm_action
  alarm_action_suffix  = local._ignore_alarm_action ? "" : " and attempts to recover if failed"
}

##### Create CloudWatch Hardware Autorecovery Monitor
module "context_cloudwatch_alarm_instance" {
  source  = "../terraform-null-context/modules/legacy"
  count   = var.enable_state_recovery == true && local.context_passed ? 1 : 0
  context = module.module_context[0].context

  flags = {
    override_name = true
    skip_checks   = true
  }

  name        = "${random_id.instance.hex}-state-autorecovery-alarm"
  description = length(var.route53_additional_cnames) != 0 ? "Monitors system state of ${aws_instance.instance.id}${local.alarm_action_suffix} for ${var.route53_additional_cnames[0]}" : "Monitors system state of ${aws_instance.instance.id}${local.alarm_action_suffix}"
}

resource "aws_cloudwatch_metric_alarm" "instance" {
  count               = var.enable_state_recovery == true ? 1 : 0
  alarm_name          = "state_recovery_${random_id.instance.hex}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = "1.0"
  actions_enabled     = true
  alarm_actions       = local.alarm_actions
  alarm_description   = local.context_passed ? module.context_cloudwatch_alarm_instance[0].description : "Monitors system state of ${aws_instance.instance.id}${local.alarm_action_suffix}"
  datapoints_to_alarm = 2
  unit                = "Count"
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
  tags = local.context_passed ? module.context_cloudwatch_alarm_instance[0].tags : {
    BuildUser     = var.build_user
    Business      = var.tag_business
    Description   = "Monitors system state of ${aws_instance.instance.id}${local.alarm_action_suffix}"
    Environment   = var.tag_environment
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    Name          = "${random_id.instance.hex}-state-autorecovery-alarm"
    Owner         = var.tag_owner
    ProvisionDate = timestamp()
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
      alarm_actions,
      ok_actions,
      datapoints_to_alarm,
      treat_missing_data
    ]
  }
}


##### Create CloudWatch Autoreboot Instance Checks Monitor
module "context_cloudwatch_alarm_instance_reboot" {
  source  = "../terraform-null-context/modules/legacy"
  count   = var.auto_reboot_instance_checks == true && local.context_passed ? 1 : 0
  context = module.module_context[0].context

  flags = {
    override_name = true
    skip_checks   = true
  }

  name        = "${random_id.instance.hex}-auto-reboot-alarm"
  description = length(var.route53_additional_cnames) != 0 ? "Monitors instance checks of ${aws_instance.instance.id}${local.alarm_action_suffix} for ${var.route53_additional_cnames[0]} and auto-reboots if failed" : "Monitors instance checks of ${aws_instance.instance.id}${local.alarm_action_suffix} and auto-reboots if failed"
}

resource "aws_cloudwatch_metric_alarm" "instance_reboot" {
  count               = var.auto_reboot_instance_checks == true ? 1 : 0
  alarm_name          = "auto_reboot_${random_id.instance.hex}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = "1.0"
  actions_enabled     = true
  alarm_actions       = ["arn:${data.aws_partition.current.partition}:automate:${local.context_passed ? module.module_context[0].region : var.aws_region}:ec2:reboot"]
  alarm_description   = local.context_passed ? module.context_cloudwatch_alarm_instance_reboot[0].description : "Monitors instance checks of ${aws_instance.instance.id} and auto-reboots if failed"
  datapoints_to_alarm = 2
  unit                = "Count"
  dimensions = {
    InstanceId = aws_instance.instance.id
  }
  tags = local.context_passed ? module.context_cloudwatch_alarm_instance_reboot[0].tags : {
    BuildUser     = var.build_user
    Business      = var.tag_business
    Description   = "Monitors instance checks of ${aws_instance.instance.id} and auto-reboots if failed"
    Environment   = var.tag_environment
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    Name          = "${random_id.instance.hex}-auto-reboot-alarm"
    Owner         = var.tag_owner
    ProvisionDate = timestamp()
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
