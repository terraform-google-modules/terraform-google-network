/*
  Description: Internal Metadata
  Comments:
*/

resource "random_id" "module" {
  prefix = var.adv_random_prefix
  keepers = {
    build_user = var.build_user
  }
  byte_length = 8
  lifecycle {
    ignore_changes = [
      keepers["build_user"],
    ]
  }
}
resource "time_static" "module" {
  triggers = {
    build_user = var.build_user
  }
  lifecycle {
    ignore_changes = [
      triggers["build_user"],
    ]
  }
}

locals {
  default_tags = merge(var.tags, {
    meta-module-id = random_id.module.hex
    ProvisionDate  = time_static.module.rfc3339
  })
}

output "metadata" {
  description = "QTM Module Metadata"
  value = {
    id            = random_id.module.hex
    ProvisionDate = time_static.module.rfc3339
  }
}
