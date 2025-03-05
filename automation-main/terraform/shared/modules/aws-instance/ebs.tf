/*
  Description: Creates EBS Volumes and attaches them to the AWS Instance
  Input Triggers:
    - additional_volumes : Map of object(size = number, type = string, iops = number, throughput = number, encrypted = bool)
  Comments: When triggered, this file will create and attach the EBS Volumes to the instance.
*/

locals {
  additional_volumes = {
    for device_name, ebs in var.additional_volumes :
    device_name => {
      size       = ebs.size
      type       = lookup(ebs, "type", null) != null ? ebs.type : "gp3"
      iops       = contains(["gp3", "io1", "io2"], lookup(ebs, "type", null) != null ? ebs.type : "gp3") ? lookup(ebs, "iops", null) : null
      throughput = (lookup(ebs, "type", null) != null ? ebs.type : "gp3") == "gp3" ? lookup(ebs, "throughput", null) : null
      encrypted  = lookup(ebs, "encrypted", var.root_encrypted)
    }
  }
}

module "context_ebs_additional_volume" {
  source   = "../terraform-null-context/modules/legacy"
  for_each = local.additional_volumes
  context  = module.module_context[0].context

  flags = {
    override_name = true
    skip_checks   = true
  }
  additional_tags = {
    AttachedInstanceId = aws_instance.instance.id
  }

  name        = "${random_id.instance.hex}-${each.key}"
  description = "${random_id.instance.hex} additional EBS volume"
}

resource "aws_ebs_volume" "additional_volume" {
  for_each          = local.additional_volumes
  availability_zone = aws_instance.instance.availability_zone ## This volume has to be created in the same AZ as the instance
  size              = each.value.size
  type              = each.value.type
  iops              = each.value.iops
  throughput        = each.value.throughput
  encrypted         = each.value.encrypted

  tags = local.context_passed ? module.context_ebs_additional_volume[each.key].tags : {
    BuildUser     = var.build_user
    Business      = var.tag_business
    Description   = "${random_id.instance.hex} additional EBS volume"
    Environment   = var.tag_environment
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    Name          = "${random_id.instance.hex}-${each.key}"
    Owner         = var.tag_owner
    ProvisionDate = timestamp()
  }

  lifecycle {
    ignore_changes = [
      tags["ProvisionDate"],
      tags["BuildUser"],
    ]
  }
}

resource "aws_volume_attachment" "additional_volume" {
  for_each    = var.additional_volumes
  device_name = "/dev/${each.key}"
  volume_id   = aws_ebs_volume.additional_volume[each.key].id
  instance_id = aws_instance.instance.id
}
