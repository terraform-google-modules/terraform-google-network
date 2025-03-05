/*
  Description: Creates Windows Constrained Endpoint
  Comments:
*/

data "aws_ami" "constrained_endpoint" {
  count       = var.create_constrained_endpoint ? 1 : 0
  most_recent = true
  filter {
    name   = var.adv_constrained_image_search_type
    values = [var.adv_constrained_image_search_value]
  }
  owners = [var.adv_constrained_image_search_owner_id]
}
resource "random_id" "constrained_endpoint" {
  count       = var.create_constrained_endpoint ? 1 : 0
  byte_length = 8
  keepers = {
    meta_ami_id   = data.aws_ami.constrained_endpoint[0].id
    meta_ami_name = data.aws_ami.constrained_endpoint[0].name
  }
  lifecycle {
    ignore_changes = [
      keepers["meta_ami_id"],
      keepers["meta_ami_name"],
    ]
  }
}

locals {
  tags_constrained_endpoint = var.create_constrained_endpoint ? merge(local.tags, {
    meta_ami_id   = random_id.constrained_endpoint[0].keepers.meta_ami_id
    meta_ami_name = random_id.constrained_endpoint[0].keepers.meta_ami_name
    Name          = "constrained-endpoint/${random_id.constrained_endpoint[0].hex}"
    ProductName   = "constrained-endpoint"
    cname         = var.constrained_endpoint_route53.zone_id == "" ? null : var.constrained_endpoint_route53.cname
  }) : {}
}
resource "aws_instance" "constrained_endpoint" {
  count                       = var.create_constrained_endpoint ? 1 : 0
  ami                         = data.aws_ami.constrained_endpoint[0].image_id
  iam_instance_profile        = var.constrained_endpoint.instance_profile
  instance_type               = var.constrained_endpoint.vm_size
  key_name                    = var.constrained_endpoint.key_name
  subnet_id                   = var.constrained_endpoint.subnet_id
  vpc_security_group_ids      = var.constrained_endpoint.security_group_ids
  user_data_base64            = "PHBvd2Vyc2hlbGw+IEluc3RhbGwtUGFja2FnZVByb3ZpZGVyIC1OYW1lIE51R2V0IC1NaW5pbXVtVmVyc2lvbiAyLjguNS4yMDEgLUZvcmNlOyBJbnN0YWxsLVdpbmRvd3NGZWF0dXJlIC1OYW1lICJSU0FULUFELVBvd2VyU2hlbGwiIC1JbmNsdWRlQWxsU3ViRmVhdHVyZSAtUmVzdGFydDokZmFsc2U7IEltcG9ydC1Nb2R1bGUgQWN0aXZlRGlyZWN0b3J5OyBHZXQtV2luZG93c0NhcGFiaWxpdHkgLU9ubGluZSB8IFdoZXJlLU9iamVjdCBOYW1lIC1saWtlICdPcGVuU1NILlNlcnZlcionIHwgQWRkLVdpbmRvd3NDYXBhYmlsaXR5IC1PbmxpbmU7IEdldC1TZXJ2aWNlIHNzaGQsc3NoLWFnZW50IHwgU2V0LVNlcnZpY2UgLVN0YXJ0dXBUeXBlIEF1dG9tYXRpYzsgR2V0LVNlcnZpY2Ugc3NoZCxzc2gtYWdlbnQgfCBTdGFydC1TZXJ2aWNlOyBTZXQtSXRlbVByb3BlcnR5IC1QYXRoICJIS0xNOlxTT0ZUV0FSRVxNaWNyb3NvZnRcUG93ZXJTaGVsbFwxXFNoZWxsSWRzIiAtTmFtZSBDb25zb2xlUHJvbXB0aW5nIC1WYWx1ZSAkdHJ1ZTsgRW5hYmxlLVBTUmVtb3Rpbmc7IE5ldy1JdGVtIC1QYXRoIEM6XCAtTmFtZSB0ZW1wIC1JdGVtVHlwZSBEaXJlY3Rvcnk7IDwvcG93ZXJzaGVsbD4="
  tags                        = local.tags_constrained_endpoint
  associate_public_ip_address = false
  monitoring                  = false
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "50"
  }
  lifecycle {
    ignore_changes = [
      ami,
      ebs_optimized,
      user_data,
      user_data_base64,
    ]
  }
}

locals {
  alarm_actions = ["arn:${local.aws_partition}:automate:${local.aws_region}:ec2:recover"]
}
resource "aws_cloudwatch_metric_alarm" "constrained_endpoint" {
  count               = var.create_constrained_endpoint ? 1 : 0
  alarm_name          = "state_recovery_${aws_instance.constrained_endpoint[0].id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = "1.0"
  actions_enabled     = true
  alarm_actions       = local.alarm_actions
  alarm_description   = "Monitors system state of ${aws_instance.constrained_endpoint[0].id} and attempts to recover if failed"
  datapoints_to_alarm = 2
  unit                = "Count"
  dimensions = {
    InstanceId = aws_instance.constrained_endpoint[0].id
  }
  tags = merge(local.tags, {
    Description = "Monitors system state of ${aws_instance.constrained_endpoint[0].id} and attempts to recover if failed"
    Name        = "state_recovery_${aws_instance.constrained_endpoint[0].id}"
  })
  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      alarm_actions,
      ok_actions,
      datapoints_to_alarm,
      treat_missing_data
    ]
  }
}

resource "aws_route53_record" "constrained_endpoint_a_record" {
  count   = var.create_constrained_endpoint && var.create_constrained_endpoint_dns_records ? 1 : 0
  zone_id = var.constrained_endpoint_route53.zone_id
  name    = aws_instance.constrained_endpoint[0].id
  ttl     = "300"
  type    = "A"
  records = [aws_instance.constrained_endpoint[0].private_ip]
}

resource "aws_route53_record" "constrained_endpoint_cname" {
  count   = var.create_constrained_endpoint && var.create_constrained_endpoint_dns_records ? 1 : 0
  zone_id = var.constrained_endpoint_route53.zone_id
  name    = var.constrained_endpoint_route53.cname
  ttl     = "300"
  type    = "CNAME"
  records = [aws_route53_record.constrained_endpoint_a_record[0].fqdn]
}

resource "aws_ssm_association" "domainjoin_association" {
  count = var.create_constrained_endpoint ? 1 : 0
  name  = aws_ssm_document.ssm_domain_join_doc.name
  targets {
    key    = "InstanceIds"
    values = [aws_instance.constrained_endpoint[0].id]
  }
}

output "constrained_endpoint" { value = var.create_constrained_endpoint ? {
  id = aws_instance.constrained_endpoint[0].id
} : null }
