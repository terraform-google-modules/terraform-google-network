/*
  Description: Terraform outputs
  Comments: N/A
*/

###### Instances
output "instance_list" { value = module.instance_list }
output "raw_instance_list" { value = var.instance_list }
output "key_pair_name" { value = aws_key_pair.main01.key_name }