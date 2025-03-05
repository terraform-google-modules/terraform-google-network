/*
  Description: Outputs for S4PCE Customer Layer-02
  Layer: 02
*/

###### Instances
output "instance_list" { value = module.instance_list }
output "raw_instance_list" { value = var.instance_list }
output "s3_additional_backup" { value = module.s3_additional_backup }
output "key_pair_name" { value = aws_key_pair.main01.key_name }
