/*
  Description: Output of the resulting SSM PatchGroup creation; Ouputs the ID of the patch group used to tag instances with
  Comments:
*/

output "patch_group" {
  value = regex("[^,]*", aws_ssm_patch_group.patch_group.id)
}
