/*
  Description: Output variables from deployment of a a single IAM role and attached policies
  Comments: N/A
*/

locals {
  instance_profile_arn  = var.iam_instance_profile_name != "" ? aws_iam_instance_profile.main01[0].arn : null
  instance_profile_name = var.iam_instance_profile_name != "" ? var.iam_instance_profile_name : null
}

output "id" { value = aws_iam_role.main01.id }
output "role_arn" { value = aws_iam_role.main01.arn }
output "role_name" { value = aws_iam_role.main01.name }
output "instance_profile_arn" { value = local.instance_profile_arn }
output "instance_profile_name" { value = local.instance_profile_name }
