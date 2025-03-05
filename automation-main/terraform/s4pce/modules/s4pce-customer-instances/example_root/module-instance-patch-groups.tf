/*
  Description: Create the patch groups required to deploy the S4PCE Instances
  Comments:
*/

# RedHat - General
module "ssm_management_rhel_general" {
  source                     = "../../../..//shared/modules/aws-ssm-patch-group-rhel-security"
  build_user                 = var.build_user
  patch_group_name           = "test-rhel-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Red Hat Enterprise Linux management infrastructure"
  rejected_patches = [
    "kernel*" # exclude kernel patches
  ]
  # # Offset patch installations Dev/QA environments by 1 week
  # security_critical_patch_approval_days  = 14
  # security_important_patch_approval_days = 14
  # security_moderate_patch_approval_days  = 14
  # security_low_patch_approval_days       = 14
  # module_dependency                      = join(",", [])
}

# Ubuntu - General
module "ssm_management_ubuntu_general" {
  source                     = "../../../..//shared/modules/aws-ssm-patch-group-ubuntu-security"
  build_user                 = var.build_user
  patch_group_name           = "test-ubuntu-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Ubuntu management infrastructure"
  rejected_patches = [
    "linux*" # exclude kernel patches
  ]
  # # Offset patch installations Dev/QA environments by 1 week
  # security_critical_patch_approval_days  = 14
  # security_important_patch_approval_days = 14
  # security_moderate_patch_approval_days  = 14
  # security_low_patch_approval_days       = 14
  # module_dependency                      = join(",", [])
}

# Windows - General
module "ssm_management_windows_general" {
  source                     = "../../../..//shared/modules/aws-ssm-patch-group-windows-security"
  build_user                 = var.build_user
  patch_group_name           = "test-windows-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Windows management infrastructure"
  # # Offset patch installations Dev/QA environments by 1 week
  # security_critical_patch_approval_days  = 14
  # security_important_patch_approval_days = 14
  # security_moderate_patch_approval_days  = 14
  # security_low_patch_approval_days       = 14
  # module_dependency                      = join(",", [])
}