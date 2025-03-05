/*
  Description: Terraform Outputs
  Comments: N/A
*/

##### Instances
output "instance_openvpn" { value = module.instance_openvpn_mfa }
output "instance_bastion" { value = module.instance_bastion }
output "instance_hana_cockpit" { value = module.instance_hana_cockpit }
output "instance_solman_abap" { value = module.instance_solman_abap }
output "instance_solman_java" { value = module.instance_solman_java }
output "instance_solman_hana" { value = module.instance_solman_hana }
output "instance_ses_postfix_host" { value = module.instance_ses_postfix_host }

##### Key Pairs
output "key_pair_main01" { value = {
  key_name = aws_key_pair.main01.key_name
  id       = aws_key_pair.main01.id
} }
