/*
  Description: Test the module
  Comments:
*/



module "s4pce_customer_infrastructure" {
  source     = "../"
  aws_region = var.aws_region
  build_user = var.build_user
  context    = module.base_context.context

  vpc_dhcp_options_id = aws_vpc_dhcp_options.test.id

  # HA
  deploy_ha_efs = false # Optional. Used for deploying HA EFS

  # AWS Backup
  enable_backup = 0 # Optional. Used to enable AWS backup. If enabled, define the variables below as well
  # adv_backup_vault_force_destroy =
  # backup_service_arn =

  # Network
  network = {
    primary = {
      primary_landscape = "production"
      landscape_default_deployment_zones = {
        production        = { default_zone = "a" }
        quality_assurance = { default_zone = "b" }
        development       = { default_zone = "c" }
      }
      cidr = "10.1.0.0/19"
      subnets = {
        production_1        = { zone = "a", cidr = "10.1.0.0/23" }
        production_2        = { zone = "b", cidr = "10.1.2.0/23" }
        production_3        = { zone = "c", cidr = "10.1.4.0/23" }
        quality_assurance_1 = { zone = "a", cidr = "10.1.6.0/23" }
        quality_assurance_2 = { zone = "b", cidr = "10.1.8.0/23" }
        quality_assurance_3 = { zone = "c", cidr = "10.1.10.0/23" }
        development_1       = { zone = "a", cidr = "10.1.12.0/23" }
        development_2       = { zone = "b", cidr = "10.1.14.0/23" }
        development_3       = { zone = "c", cidr = "10.1.16.0/23" }
      }
      subnets_edge = {
        edge_1 = { zone = "a", cidr = "10.1.20.0/26" }
        edge_2 = { zone = "b", cidr = "10.1.20.64/26" }
        edge_3 = { zone = "c", cidr = "10.1.20.128/26" }
      }
    }
  }

  custom_no_nat_gateways         = false         # Optional. Disables the creation of NGWs in the private subnet
  custom_no_local_dns_zone       = false         # Optional. Use Local Account dns zone
  custom_efs_throughput_mode     = "provisioned" # Optional. Use Local Account EFS throughput mode
  custom_efs_throughput_in_mibps = 20            # Optional. Use Local Account EFS throughput in mibps

  # Route 53
  route53_zone_management_id = aws_route53_zone.test.id

  # Additional AWS Endpoints
  additional_endpoints_creation = false # Optional. Used for Restricted Environments requiring additional private service endpoints
  additional_endpoints          = []    # Optional. This is an advanced setting for Restricted Environments requiring additional private service endpoints

  # S3 Bucket
  bucket_expiration        = "Disabled" # Optional. Enable/Disable customer s3 backup bucket_expiration rule
  bucket_retention_days    = 180        # Optional. Number of days before objects are deleted from S3 backup bucket
  versioning               = "Enabled"  # Optional. Enable/Disable customer s3 backup bucket versioning
  default_lifecycle_status = "Enabled"  # Optional. Whether default LCM rule is enabled/disabled
  transition_days_s3ia     = 30         # Optional. Number of days before objects are transitioned to IA
  transition_days_glacier  = 60         # Optional. Number of days before objects are transitioned to glacier

  # Module Dependency
  module_dependency = "" # Optional. Deprecated. To Be Removed
}

output "infrastructure" { value = module.s4pce_customer_infrastructure }
