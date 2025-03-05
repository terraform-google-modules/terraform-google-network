/*
  Description: Terraform main file; This shows how to integrate the aws-ssm-patch-group-rhel-all module into a root module
  Comments:
    - Each SSM PatchGroup must be specified as seperate module calls in the root module
*/


##### Documentation of module inputs
// module "ssm_patch_group_all_inputs_example" {
//   source                     = "../../aws-ssm-patch-group-rhel-all"  # This should point back to the original module.
//   build_user                 = ""                                    # (required) (string) Employee ID of the user running terraform
//   patch_group_name           = ""                                    # (required) (string) Name of the patch group to be created
//   patch_baseline_description = ""                                    # (required) (string) Description of the Patch Baseline
//   approved_patches           = []                                    # (optional) (list) Patches that are explicitly approved
//   rejected_patches           = []                                    # (optional) (list) Patches that are explicitly rejected
//   redhat_versions            = []                                    # (optional) (list) Redhat versions covered by the patch group
//   security_critical_patch_approval_days  =                           # (optional) (int) Number of days critical patches must be applied by
//   security_important_patch_approval_days =                           # (optional) (int) Number of days important patches must be applied by
//   security_moderate_patch_approval_days  =                           # (optional) (int) Number of days moderate patches must be applied by
//   security_low_patch_approval_days       =                           # (optional) (int) Number of days low patches must be applied by
//   module_dependency                      = join(",", [])             # Use this to make the module depend on an external factor
// }

##### Example SSM PatchGroup Module Calls
# Only required inputs (the rest of the parameters all use set defaults, consult documentation for details)
module "ssm_patch_group_required_inputs_example" {
  source                     = "../../aws-ssm-patch-group-rhel-security"
  build_user                 = var.build_user
  patch_group_name           = "test-patch-group"
  patch_baseline_description = "test patch baseline description"
  module_dependency          = join(",", [])
}

# All input options
module "ssm_patch_group_all_inputs_example" {
  source                     = "../../aws-ssm-patch-group-rhel-security"
  build_user                 = var.build_user
  patch_group_name           = "test-patch-group-full"
  patch_baseline_description = "test patch baseline description"
  approved_patches           = []
  rejected_patches = [
    "kernel*"
  ]
  redhat_versions = [
    "RedhatEnterpriseLinux7.5",
    "RedhatEnterpriseLinux7.6",
    "RedhatEnterpriseLinux7.7"
  ]
  security_critical_patch_approval_days  = 2
  security_important_patch_approval_days = 2
  security_moderate_patch_approval_days  = 4
  security_low_patch_approval_days       = 7
  module_dependency                      = join(",", [])
}
