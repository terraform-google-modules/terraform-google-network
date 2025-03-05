/*
  Description: Creates IAM Groups and attaches policies; Takes values from the tfvar and remaps them to a local variables.
    Terraform uses the local variables to generate IAM groups and attach policies.
  Comments: N/A
*/

##### Module Dependency
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

# Create IAM Group
resource "aws_iam_group" "iam_group" {
  name = var.iam_group_object.name
}

# Map IAM Group to all Policies passed to module
resource "aws_iam_group_policy_attachment" "iam_group" {
  count      = length(var.iam_group_object.policy_list)
  group      = aws_iam_group.iam_group.id
  policy_arn = var.iam_group_object.policy_list[count.index]

  depends_on = [aws_iam_group.iam_group]
}
