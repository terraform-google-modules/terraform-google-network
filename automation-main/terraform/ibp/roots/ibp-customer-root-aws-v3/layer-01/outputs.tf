/*
  Description: Outputs
  Comments: N/A
*/

# EFS
output "efs_customer_usr_sap_trans_id" { value = aws_efs_file_system.customer_usr_sap_trans.id }
output "efs_customer_usr_sap_trans_ip_1a" { value = aws_efs_mount_target.customer_usr_sap_trans["a"].ip_address }
output "efs_customer_usr_sap_trans" { value = {
  "id" = aws_efs_file_system.customer_usr_sap_trans.id
  "target" = { for key, value in local.efs_subnet_mounts : key => {
    "ip_address" = aws_efs_mount_target.customer_usr_sap_trans[key].ip_address
  } }
} }

# IAM
output "iam_role_customer_default_id" { value = module.iam_role_customer_default.id }
output "iam_role_customer_database_id" { value = module.iam_role_customer_database.id }
output "iam_role_customer_ibpapp_id" { value = module.iam_role_customer_ibpapp.id }
