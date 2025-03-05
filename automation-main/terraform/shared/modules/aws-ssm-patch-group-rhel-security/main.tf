/*
  Description: Creates SSM PatchGroup with corresponding Baseline; Generates standard set of compliance reporting for types of patches at repective severity levels
  Comments: NA
*/

##### Patch Baseline
resource "aws_ssm_patch_baseline" "patch_baseline" {
  name             = random_id.patch_group.hex
  description      = var.patch_baseline_description
  operating_system = "REDHAT_ENTERPRISE_LINUX"
  approved_patches = var.approved_patches
  rejected_patches = var.rejected_patches
  # security patches - critical
  approval_rule {
    approve_after_days = var.security_critical_patch_approval_days
    compliance_level   = "CRITICAL"
    patch_filter {
      key    = "PRODUCT"
      values = var.redhat_versions
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["Critical"]
    }
  }
  # security patches - important
  approval_rule {
    approve_after_days = var.security_important_patch_approval_days
    compliance_level   = "HIGH"
    patch_filter {
      key    = "PRODUCT"
      values = var.redhat_versions
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["Important"]
    }
  }
  # security patches - moderate
  approval_rule {
    approve_after_days = var.security_moderate_patch_approval_days
    compliance_level   = "MEDIUM"
    patch_filter {
      key    = "PRODUCT"
      values = var.redhat_versions
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["Moderate"]
    }
  }
  # security patches - low
  approval_rule {
    approve_after_days = var.security_low_patch_approval_days
    compliance_level   = "LOW"
    patch_filter {
      key    = "PRODUCT"
      values = var.redhat_versions
    }
    patch_filter {
      key    = "CLASSIFICATION"
      values = ["Security"]
    }
    patch_filter {
      key    = "SEVERITY"
      values = ["Low"]
    }
  }
  tags = {
    Name         = random_id.patch_group.hex
    Description  = var.patch_baseline_description
    Generated-By = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
    ]
  }
}

##### PatchGroup
resource "aws_ssm_patch_group" "patch_group" {
  baseline_id = aws_ssm_patch_baseline.patch_baseline.id
  patch_group = random_id.patch_group.keepers.patch_group_name
}
