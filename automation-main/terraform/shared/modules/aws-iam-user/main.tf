/*
  Description: Create IAM users, attach policies and add to groups
  Comments: N/A
*/

##### Module Dependency
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

# Create IAM users
resource "aws_iam_user" "iam_user" {
  name = var.aws-iam-user-object.name
  tags = {
    Name          = var.aws-iam-user-object.name
    Generated-By  = "terraform"
    ProvisionDate = timestamp()
    BuildUser     = var.build_user
    Company       = var.aws-iam-user-object.tag_company
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

# Attach policies to the IAM users
resource "aws_iam_user_policy_attachment" "iam_user" {
  count      = length(var.aws-iam-user-object.policy_list)
  user       = aws_iam_user.iam_user.id
  policy_arn = var.aws-iam-user-object.policy_list[count.index]

  depends_on = [aws_iam_user.iam_user]
}

# Add IAM Users to IAM Group
resource "aws_iam_user_group_membership" "iam_user" {
  groups = var.aws-iam-user-object.group_list
  user   = aws_iam_user.iam_user.id

  depends_on = [aws_iam_user.iam_user]
}
