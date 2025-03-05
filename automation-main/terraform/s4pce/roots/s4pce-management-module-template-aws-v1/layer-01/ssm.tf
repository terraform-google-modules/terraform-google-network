/*
  Description: Manage Amazon Systems Manager (SSM) to:
  Comments:
    PatchGroups:
      ssm_management_rhel_general
      ssm_management_ubuntu_general
      ssm_management_windows_general
      ssm_customer_rhel_general
      ssm_customer_ubuntu_general
      ssm_customer_windows_general
*/

####### SSM Patching
locals {
  ssm_service_arn = "arn:${module.base_layer_context.partition}:iam::${module.base_layer_context.account_id}:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"
}

##### Patch Scanning - Account Global (all SSM managed instances)
locals {
  global_patch_scan_timing = "every day 4:00AM-7:00AM EST or 8:00AM-11:00AM UTC"
}

module "context_ssm_window_account_scan" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context = module.base_layer_context.context

  name        = "patch-scan-window"
  description = "Window schedules patch scanning ${local.global_patch_scan_timing}"
}

resource "aws_ssm_maintenance_window" "account_scan" {
  name              = module.context_ssm_window_account_scan.name
  description       = module.context_ssm_window_account_scan.description
  tags              = module.context_ssm_window_account_scan.tags
  schedule          = "cron(0 4 ? * * *)"
  duration          = "3"
  cutoff            = "1"
  schedule_timezone = "America/New_York"

}

resource "aws_ssm_maintenance_window_target" "account_scan_management" {
  window_id         = aws_ssm_maintenance_window.account_scan.id
  name              = "${module.base_layer_context.resource_prefix}-patch-scan-window-target"
  description       = "Management instances managed my SSM to be targeted for patch scanning ${local.global_patch_scan_timing}"
  resource_type     = "INSTANCE"
  owner_information = module.base_layer_context.owner
  targets {
    key    = "tag:PatchGroup"
    values = local.ssm_management_patch_groups
  }
}
resource "aws_ssm_maintenance_window_target" "account_scan_customer" {
  window_id         = aws_ssm_maintenance_window.account_scan.id
  name              = "${module.context_ssm_customer_patching.resource_prefix}-patch-scan-window-target"
  description       = "Customer instances managed my SSM to be targeted for patch scanning ${local.global_patch_scan_timing}"
  resource_type     = "INSTANCE"
  owner_information = module.base_layer_context.owner
  targets {
    key    = "tag:PatchGroup"
    values = local.ssm_customer_patch_groups
  }
}

resource "aws_ssm_maintenance_window_task" "account_scan" {
  window_id        = aws_ssm_maintenance_window.account_scan.id
  description      = "Scan all SSM managed instances for patches ${local.global_patch_scan_timing}"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = local.ssm_service_arn
  max_concurrency  = "100%"
  max_errors       = "100%"
  targets {
    key = "WindowTargetIds"
    values = [
      aws_ssm_maintenance_window_target.account_scan_management.id,
      aws_ssm_maintenance_window_target.account_scan_customer.id
    ]
  }
  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Scan"]
      }
      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
      output_s3_bucket     = module.s3_ssm_patching.bucket_names
      output_s3_key_prefix = "scans"
      comment              = "Scan all SSM managed instances for patches ${local.global_patch_scan_timing}"
    }
  }
}

##### PatchGroups
### Management
module "context_ssm_management_patching" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  label_order = ["security_boundary", "business"]
  name_prefix = "EXAMPLE_TESTING_UNIQUE_management"
}

locals {
  ssm_management_patch_groups = [
    module.ssm_management_rhel_general.patch_group,
    module.ssm_management_ubuntu_general.patch_group,
    module.ssm_management_windows_general.patch_group
  ]
}

# RedHat - General
module "ssm_management_rhel_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-rhel-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_management_patching.resource_prefix}-rhel-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Red Hat Enterprise Linux management infrastructure"
  rejected_patches = [
    "kernel*" # exclude kernel patches
  ]
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}

# Ubuntu - General
module "ssm_management_ubuntu_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-ubuntu-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_management_patching.resource_prefix}-ubuntu-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Ubuntu management infrastructure"
  rejected_patches = [
    "linux*" # exclude kernel patches
  ]
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}

# Windows - General
module "ssm_management_windows_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-windows-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_management_patching.resource_prefix}-windows-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Windows management infrastructure"
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}

### Customer
module "context_ssm_customer_patching" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  label_order = ["security_boundary", "business"]
  name_prefix = "EXAMPLE_TESTING_UNIQUE_customer"
}

locals {
  ssm_customer_patch_groups = [
    module.ssm_customer_rhel_general.patch_group,
    module.ssm_customer_ubuntu_general.patch_group,
    module.ssm_customer_windows_general.patch_group
  ]
}

# RedHat - General
module "ssm_customer_rhel_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-rhel-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_customer_patching.resource_prefix}-rhel-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Red Hat Enterprise Linux customer infrastructure"
  rejected_patches = [
    "kernel*" # exclude kernel patches
  ]
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}

# Ubuntu - General
module "ssm_customer_ubuntu_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-ubuntu-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_customer_patching.resource_prefix}-ubuntu-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Ubuntu customer infrastructure"
  rejected_patches = [
    "linux*" # exclude kernel patches
  ]
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}

# Windows - General
module "ssm_customer_windows_general" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/aws-ssm-patch-group-windows-security"
  build_user                 = var.build_user
  patch_group_name           = "${module.context_ssm_customer_patching.resource_prefix}-windows-general"
  patch_baseline_description = "Terraform-managed baseline for general SSM automated patching on Windows customer infrastructure"
  # Offset patch installations Dev/QA environments by 1 week
  security_critical_patch_approval_days  = 14
  security_important_patch_approval_days = 14
  security_moderate_patch_approval_days  = 14
  security_low_patch_approval_days       = 14
  module_dependency                      = join(",", [])
}


##### Patch Installation
### Management
locals {
  management_patch_install_timing = "every SAT 8:00AM-10:00AM EST or 12:00PM-2:00PM UTC"
}

module "context_ssm_window_management_patch_install" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context = module.base_layer_context.context

  name        = "patch-install-window"
  description = "Window schedules patch installation ${local.management_patch_install_timing}"
}

resource "aws_ssm_maintenance_window" "management_patch_install" {
  name              = module.context_ssm_window_management_patch_install.name
  description       = module.context_ssm_window_management_patch_install.description
  tags              = module.context_ssm_window_management_patch_install.tags
  schedule          = "cron(0 8 ? * SAT *)"
  duration          = "2"
  cutoff            = "0"
  schedule_timezone = "America/New_York"
}

resource "aws_ssm_maintenance_window_target" "management_patch_install" {
  window_id     = aws_ssm_maintenance_window.management_patch_install.id
  name          = "${module.base_layer_context.resource_prefix}-patch-install-target"
  description   = "Instances to be targeted for patch installation ${local.management_patch_install_timing}"
  resource_type = "INSTANCE"
  targets {
    key    = "tag:PatchGroup"
    values = local.ssm_management_patch_groups
  }
}

resource "aws_ssm_maintenance_window_task" "management_patch_install" {
  name             = "${module.base_layer_context.resource_prefix}-patch-install-task"
  window_id        = aws_ssm_maintenance_window.management_patch_install.id
  description      = "Install approved patches on targeted instances ${local.management_patch_install_timing}"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = local.ssm_service_arn
  max_concurrency  = "100%"
  max_errors       = "25%"
  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.management_patch_install.id]
  }
  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Install"]
      }
      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
      output_s3_bucket     = module.s3_ssm_patching.bucket_names
      output_s3_key_prefix = "patches/${module.base_layer_context.custom_values.kv.vpc}"
      comment              = "Install approved patches on targeted instances ${local.management_patch_install_timing}"
    }
  }
}

### Customer
locals {
  customer_patch_install_timing = "every THU 8:00PM-10:00PM EST or 12:00AM-2:00AM UTC"
}

module "context_ssm_window_customer_patch_install" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context = module.context_ssm_customer_patching.context

  name        = "patch-install-window"
  description = "Window schedules patch installation ${local.customer_patch_install_timing}"
}

resource "aws_ssm_maintenance_window" "customer_patch_install" {
  name              = module.context_ssm_window_customer_patch_install.name
  description       = module.context_ssm_window_customer_patch_install.description
  tags              = module.context_ssm_window_customer_patch_install.tags
  schedule          = "cron(0 20 ? * THU *)"
  duration          = "2"
  cutoff            = "0"
  schedule_timezone = "America/New_York"
}

resource "aws_ssm_maintenance_window_target" "customer_patch_install" {
  window_id     = aws_ssm_maintenance_window.customer_patch_install.id
  name          = "${module.context_ssm_customer_patching.resource_prefix}-patch-install-target"
  description   = "Instances to be targeted for patch installation ${local.customer_patch_install_timing}"
  resource_type = "INSTANCE"
  targets {
    key    = "tag:PatchGroup"
    values = local.ssm_customer_patch_groups
  }
}

resource "aws_ssm_maintenance_window_task" "customer_patch_install" {
  name             = "${module.context_ssm_customer_patching.resource_prefix}-patch-install-task"
  window_id        = aws_ssm_maintenance_window.customer_patch_install.id
  description      = "Install approved patches on targeted instances ${local.customer_patch_install_timing}"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = 1
  service_role_arn = local.ssm_service_arn
  max_concurrency  = "100%"
  max_errors       = "25%"
  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.customer_patch_install.id]
  }
  task_invocation_parameters {
    run_command_parameters {
      parameter {
        name   = "Operation"
        values = ["Install"]
      }
      parameter {
        name   = "RebootOption"
        values = ["NoReboot"]
      }
      output_s3_bucket     = module.s3_ssm_patching.bucket_names
      output_s3_key_prefix = "patches/customer"
      comment              = "Install approved patches on targeted instances ${local.customer_patch_install_timing}"
    }
  }
}
