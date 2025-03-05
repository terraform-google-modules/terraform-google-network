/*
  Description: Creates the Bootstrapped Instance.
  Comments: See `userdata.sh` for the bootstrapping script.
*/

resource "time_static" "docker_bastion" {
  for_each = toset(var.docker_bastion_list)
  triggers = {
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [triggers["build_user"]]
  }
}
locals {
  tags = { for key in toset(var.docker_bastion_list) : key =>
    merge(var.tags, {
      Name          = "${key}-docker-bastion"
      BuildUser     = time_static.docker_bastion[key].triggers.build_user
      ProvisionDate = time_static.docker_bastion[key].rfc3339
      meta-key      = key
  }) }
}
resource "aws_instance" "docker_bastion" {
  for_each = toset(var.docker_bastion_list)

  ami                         = var.image_ubuntu
  instance_type               = var.adv_vm_size
  key_name                    = var.key_name
  iam_instance_profile        = var.adv_iam_instance_profile
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  user_data                   = file("${path.module}/userdata.sh")
  tags                        = local.tags[each.key]
  associate_public_ip_address = var.adv_public_ip
  monitoring                  = false
  root_block_device {
    delete_on_termination = true
  }
}

output "docker_bastions" {
  value = { for key, value in aws_instance.docker_bastion : key => {
    id         = value.id
    public_ip  = value.public_ip
    private_ip = value.private_ip
    name       = value.tags.Name
  } }
}
