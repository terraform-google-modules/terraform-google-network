/*
  Description: Terraform main file; Base infrastructure for S4PCE
  Comments:
*/

##### Infrastructure (VPC, Subnets, security groups etc.)
module "s4pce_customer_infrastructure" {
  source     = "EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure-v2"
  aws_region = module.base_layer_context.region
  build_user = module.base_layer_context.build_user
  context    = module.base_layer_context.context

  vpc_dhcp_options_id = local.management_layer_00_outputs.vpc_main01.dhcp_options_id

  # HA
  deploy_ha_efs = var.deploy_ha_efs

  # AWS Backup
  enable_backup                  = var.enable_backup
  adv_backup_vault_force_destroy = var.adv_backup_vault_force_destroy
  backup_service_arn             = local.management_layer_01_outputs.iam_role_awsbackup.role_arn

  # Network
  network                        = var.network
  custom_no_nat_gateways         = var.custom_no_nat_gateways
  custom_no_local_dns_zone       = var.custom_no_local_dns_zone
  custom_efs_throughput_mode     = var.custom_efs_throughput_mode
  custom_efs_throughput_in_mibps = var.custom_efs_throughput_in_mibps

  # Route 53
  route53_zone_management_id = local.management_layer_00_outputs.route53_zone_main01.id

  # Additional AWS Endpoints
  additional_endpoints_creation = var.additional_endpoints_creation
  additional_endpoints          = var.additional_endpoints

  # S3 Bucket
  bucket_expiration        = var.bucket_expiration
  bucket_retention_days    = var.bucket_retention_days
  versioning               = var.versioning
  default_lifecycle_status = var.default_lifecycle_status
  transition_days_s3ia     = var.transition_days_s3ia
  transition_days_glacier  = var.transition_days_glacier

}
output "infrastructure" { value = module.s4pce_customer_infrastructure }
