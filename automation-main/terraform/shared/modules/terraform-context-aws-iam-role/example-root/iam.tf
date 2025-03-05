/*
  Description: Create IAM Role
  Comments:
    ##### Required parameters
    context = null-context metadata to be passed in
    iam_role_name = Name used for both role name and tag name.
    iam_role_description = Description used for both role description and tag description
    iam_policy_arn_list = List of IAM policies to attach
    iam_instance_profile_name = The instance profile to create. Set to blank "" for no profile.
    assume_role_policy = JSON of the role policy to attach to the role.

    ###### Optional parameters
    iam_role_force_detach_policies = Default 'false'. When true, terraform attempts to detach all policies before destroy.
    iam_role_max_session_duration = Default '3600'. Time in seconds for the role's session duration.
    iam_role_path = Default 'null'. Optional AWS IAM path to save the Role to. Must begin and end with a '/'
*/

module "iam_testrole1_required_options" {
  source               = "../../../modules/terraform-context-aws-iam-role"
  context              = module.base_context.context
  iam_role_name        = lower("${module.base_context.resource_prefix}-testrole1")
  iam_role_description = title("${module.base_context.environment_values.kv.prefix_friendly_name} Test Role 1")
  iam_policy_arn_list = [
    "arn:aws-us-gov:iam::aws:policy/TranslateReadOnly"
  ]
  iam_instance_profile_name = ""
  assume_role_policy        = file("${path.module}/../../templates/iam/trust/ec2-role-trust-policy.json")
}

module "iam_testrole2_full_options" {
  source                         = "../../../modules/terraform-context-aws-iam-role"
  context                        = module.base_context.context
  iam_role_name                  = lower("${module.base_context.resource_prefix}-testrole2")
  iam_role_description           = title("${module.base_context.environment_values.kv.prefix_friendly_name} Test Role 2")
  iam_role_path                  = "/optional-path/"
  iam_role_force_detach_policies = "true"
  iam_role_max_session_duration  = "4800"
  iam_policy_arn_list = [
    "arn:aws-us-gov:iam::aws:policy/TranslateReadOnly",
    "arn:aws-us-gov:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ]
  iam_instance_profile_name = lower("${module.base_context.resource_prefix}-testrole2")
  assume_role_policy        = file("${path.module}/../../templates/iam/trust/ec2-role-trust-policy.json")
}
