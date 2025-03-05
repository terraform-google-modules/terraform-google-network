/*
  Description: Terraform input variables; Variables for the SSM PatchGroup Module
  Comments: NA
*/

variable "module_dependency" {
  default = ""
}

variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

variable "patch_group_name" {
  description = "Name of the patch group to be created."
}

variable "patch_baseline_description" {
  description = "The description of the patch baseline."
  default     = ""
}

variable "approved_patches" {
  description = "A list of explicitly approved patches for the baseline."
  default     = []
}

variable "rejected_patches" {
  description = "A list of explicitly rejected patches for the baseline."
  default     = []
}

variable "redhat_versions" {
  description = "A list of RedHat versions to approve patches for. A maximum of 20 versions may be defined."
  default     = ["*"]

  validation {
    condition     = length(var.redhat_versions) <= 20
    error_message = "The maximum number of 'redhat_versions' that may be defined is 20."
  }
}

variable "security_critical_patch_approval_days" {
  description = "The number of days after the release date of each patch classified as Security - Critial is marked as approved in the patch baseline."
  default     = 7
}

variable "security_important_patch_approval_days" {
  description = "The number of days after the release date of each patch classified as Security - Important is marked as approved in the patch baseline."
  default     = 7
}

variable "security_moderate_patch_approval_days" {
  description = "The number of days after the release date of each patch classified as Security - Moderate is marked as approved in the patch baseline."
  default     = 7
}

variable "security_low_patch_approval_days" {
  description = "The number of days after the release date of each patch classified as Security - Low is marked as approved in the patch baseline."
  default     = 7
}
