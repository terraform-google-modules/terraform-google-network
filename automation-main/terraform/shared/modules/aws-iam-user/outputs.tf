/*
  Description: Output variables for iam user
  Comments: N/A
*/

output "name" { value = aws_iam_user.iam_user.name }
output "arn" { value = aws_iam_user.iam_user.arn }
output "tags" { value = aws_iam_user.iam_user.tags }
output "group_membership" { value = aws_iam_user_group_membership.iam_user.groups }
output "attached_policies" { value = aws_iam_user_policy_attachment.iam_user[*].policy_arn }
