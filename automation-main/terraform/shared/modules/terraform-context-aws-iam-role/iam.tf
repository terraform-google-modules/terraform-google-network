/*
  Description: Creates IAM Role
  Comments: N/A
*/

# Create IAM Role
resource "aws_iam_role" "main01" {
  name                  = var.iam_role_name
  description           = var.iam_role_description
  path                  = var.iam_role_path
  force_detach_policies = var.iam_role_force_detach_policies
  tags = merge(module.base_layer_context.tags, {
    Name        = var.iam_role_name
    Description = var.iam_role_description
  })
  assume_role_policy   = var.assume_role_policy
  max_session_duration = var.iam_role_max_session_duration
}


# Map IAM Role to all IAM Policies passed to module
resource "aws_iam_role_policy_attachment" "main01" {
  role       = aws_iam_role.main01.name
  count      = length(var.iam_policy_arn_list)
  policy_arn = var.iam_policy_arn_list[count.index]
}


# Create IAM instance profile and map IAM Role to all IAM instance profile names passed to module
resource "aws_iam_instance_profile" "main01" {
  count = var.iam_instance_profile_name != "" ? 1 : 0
  name  = var.iam_instance_profile_name
  path  = var.iam_role_path
  role  = aws_iam_role.main01.name
}
