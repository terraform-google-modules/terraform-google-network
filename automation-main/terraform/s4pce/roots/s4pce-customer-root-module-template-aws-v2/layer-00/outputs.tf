###EFS related
output "efs_common_stagings_1a_ip" { value = data.terraform_remote_state.management_layer_01.outputs.efs_common_staging.ip_address["1a"] }
