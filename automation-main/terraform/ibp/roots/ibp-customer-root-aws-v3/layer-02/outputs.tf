/*
  Description: Outputs
  Comments: N/A
*/

# Instances
output "instance_map" { value = module.instance_map }
output "instance_cpids" { value = module.instance_map["instance_cpids"] }
output "instance_webdispatcher" { value = module.instance_map["instance_webdispatcher"] }
output "instance_staging_ibpdb" { value = module.instance_map["instance_staging_ibpdb"] }
output "instance_staging_ibpapp" { value = module.instance_map["instance_staging_ibpapp"] }
output "instance_production_ibpdb" { value = module.instance_map["instance_production_ibpdb"] }
output "instance_production_ibpapp" { value = module.instance_map["instance_production_ibpapp"] }
output "keypair_main01" { value = {
  arn         = aws_key_pair.main01.arn
  id          = aws_key_pair.main01.id
  key_pair_id = aws_key_pair.main01.key_pair_id
} }

# Loadbalancers
output "lb_target_group_cpids_arn" { value = aws_lb_target_group.cpids.arn }
output "certificate_cpids_internal_arn" { value = aws_acm_certificate.cpids_internal.arn }
output "loadbalancer_cert_fqdn" { value = var.loadbalancer_cert_fqdn }

# Metadata
output "aws_region" { value = var.aws_region }
output "cpids_alb_cname" { value = var.loadbalancer_cert_fqdn }
output "efs_staging_ip" { value = local.management_layer_01_outputs.efs_common_staging.ip_address["1a"] }
output "efs_usrsaptrans_ip" { value = local.layer_01_outputs.efs_customer_usr_sap_trans_ip_1a }
