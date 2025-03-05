/*
  Description: Creates IAM Policy for AWS Workspaces
  Comments:
*/


resource "random_id" "workspace_fullaccess_policy" {
  count       = var.create_workspace_fullaccess_policy ? 1 : 0
  byte_length = 4
}
locals {
  workspace_fullaccess_policy = var.create_workspace_fullaccess_policy ? {
    tags = merge(local.tags, {
      meta_name = "workspace-fullaccess-${random_id.workspace_fullaccess_policy[0].hex}"
    })
    policy = templatefile("${path.module}/templates/workspace-fullaccess-policy.json", {})
  } : { tags = {}, policy = "" }
}
resource "aws_iam_policy" "workspace_fullaccess_policy" {
  count       = var.create_workspace_fullaccess_policy ? 1 : 0
  name        = local.workspace_fullaccess_policy.tags.meta_name
  description = "Allows resources full access to directory services and workspaces."
  policy      = local.workspace_fullaccess_policy.policy
  tags        = local.workspace_fullaccess_policy.tags
}
output "workspace_fullaccess_policy" {
  value = var.create_workspace_fullaccess_policy ? {
    meta_name = aws_iam_policy.workspace_fullaccess_policy[0].name
    arn       = aws_iam_policy.workspace_fullaccess_policy[0].arn
  } : null
}
