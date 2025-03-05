/*
  Description: Deploy a single IAM role with policy attachments and optionally create instance profiles with the created role
  Comments: N/A
*/

##### Module Dependency
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

# Create IAM Role
resource "aws_iam_role" "iam_role" {
  name        = var.iam_role_name
  description = var.iam_role_description
  tags = {
    Name          = var.iam_role_name
    Description   = var.iam_role_description
    Generated-By  = "terraform"
    Managed-By    = var.tag_managedby
    ProvisionDate = timestamp()
    BuildUser     = var.build_user
  }
  lifecycle {
    ignore_changes = [tags]
  }
  assume_role_policy = var.assume_role_policy
}


# Map IAM Role to all IAM Policies passed to module
resource "aws_iam_role_policy_attachment" "iam_role_policy_attach" {
  role       = aws_iam_role.iam_role.name
  count      = length(var.iam_policy_arn_list)
  policy_arn = var.iam_policy_arn_list[count.index]
}


# Create IAM instance profile and map IAM Role to all IAM instance profile names passed to module
resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.iam_instance_profile_name != "" ? 1 : 0
  name  = var.iam_instance_profile_name
  role  = aws_iam_role.iam_role.name
}

# FTF Hashicorp changed the behavior from returning null on empty lists to throwing an error. FTF
# Looks like Hashicorp updated with this PR - https://github.com/hashicorp/terraform/pull/22846
locals {
  instance_profile_arn  = var.iam_instance_profile_name != "" ? aws_iam_instance_profile.iam_instance_profile[*].arn : null
  instance_profile_name = var.iam_instance_profile_name != "" ? var.iam_instance_profile_name : null
}
