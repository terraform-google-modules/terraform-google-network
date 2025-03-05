/*
  Description: Output variables from deployment of a a single IAM role and attached policies
  Comments: N/A
*/


output "id" { value = aws_iam_role.iam_role.id }
output "role_arn" { value = aws_iam_role.iam_role.arn }
output "role_name" { value = aws_iam_role.iam_role.name }
output "instance_profile_arn" { value = local.instance_profile_arn }
output "instance_profile_name" { value = local.instance_profile_name }
