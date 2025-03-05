/*
  Description: Variables needed to deploy a single IAM role, attached policies, and optionally create instance profiles from with the created role
  Comments: N/A
*/

variable "iam_role_name" {
  description = "Name for IAM Role"
}

variable "iam_role_description" {
  description = "Description for IAM Role"
}

variable "iam_role_path" {
  description = "Optional Path for IAM Role. Must begin and end with '/'"
  default     = null
}

variable "iam_role_force_detach_policies" {
  description = "Forces policy detachment before destroy"
  default     = "false"
}

variable "iam_role_max_session_duration" {
  description = "Maximum session time in seconds for role"
  default     = "3600"
}

variable "assume_role_policy" {
  description = "(JSON) AWS trust policy that allows for the IAM Role Assume a different AWS role"
}

variable "iam_policy_arn_list" {
  description = "List of IAM Policy ARNs to attach to the IAM Role"
  type        = list(string)
}

variable "iam_instance_profile_name" {
  description = "IAM Instance Profiles to create and attach to the IAM Role"
}
