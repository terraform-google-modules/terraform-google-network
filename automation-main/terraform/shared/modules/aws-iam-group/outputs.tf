/*
  Description: Output variables for aws-iam-group module
  Comments: N/A
*/

output "iam_group" { value = aws_iam_group.iam_group }
output "iam_group_name" { value = aws_iam_group.iam_group.name }
output "iam_group_arn" { value = aws_iam_group.iam_group.arn }
output "iam_group_id" { value = aws_iam_group.iam_group.id }
output "iam_group_policies" { value = aws_iam_group_policy_attachment.iam_group[*].policy_arn }
