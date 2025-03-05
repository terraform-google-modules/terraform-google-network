/*
  Description: Test the module
  Comments:
*/



module "s4pce_customer_infrastructure" {
  source                          = "../"
  aws_region                      = var.aws_region
  build_user                      = var.build_user
  context                         = module.base_context.context
  vpc_name                        = "test-s4pce-customer-infrastructure"
  vpc_cidr_block                  = "10.0.0.0/16"
  vpc_dhcp_options_id             = aws_vpc_dhcp_options.test.id
  route53_zone_management_id      = aws_route53_zone.test.id
  subnet_production_1a_cidr_block = "10.0.1.0/24"
  subnet_production_1b_cidr_block = "10.0.2.0/24"
  subnet_production_1c_cidr_block = "10.0.3.0/24"

  subnet_quality_assurance_1a_cidr_block = "10.0.4.0/24"
  subnet_quality_assurance_1b_cidr_block = "10.0.5.0/24"
  subnet_quality_assurance_1c_cidr_block = "10.0.6.0/24"

  subnet_development_1a_cidr_block = "10.0.7.0/24"
  subnet_development_1b_cidr_block = "10.0.8.0/24"
  subnet_development_1c_cidr_block = "10.0.9.0/24"

  subnet_edge_1a_cidr_block = "10.0.10.0/24"
  subnet_edge_1b_cidr_block = "10.0.11.0/24"
  subnet_edge_1c_cidr_block = "10.0.12.0/24"

  ### Hidden Advanced Variables
  # These variables are not intended to be modified
  # but provide advanced configuration options
  # or compensate lack of feature parity.
  # Limited support is provided for these variables, use at your own risk.

  additional_endpoints_creation  = false         # Optional. Used for Restricted Environments requiring additional private service endpoints
  additional_endpoints           = []            # Optional. This is an advanced setting for Restricted Environments requiring additional private service endpoints
  module_dependency              = ""            # Optional. Deprecated. To Be Removed
  useZoneD                       = false         # "Optional.  Use zone D instead of zone C"
  custom_no_nat_gateways         = false         # Optional. Disables the creation of NGWs in the private subnet
  custom_no_local_dns_zone       = false         # Optional. Use Local Account dns zone
  custom_efs_throughput_mode     = "provisioned" # Optional. Use Local Account EFS throughput mode
  custom_efs_throughput_in_mibps = 20            # Optional. Use Local Account EFS throughput in mibps
  bucket_expiration              = "Disabled"    # Optional. Enable/Disable customer s3 backup bucket_expiration rule
  bucket_retention_days          = 180           # Optional. Number of days before objects are deleted from S3 backup bucket
  versioning                     = "Enabled"     # Optional. Enable/Disable customer s3 backup bucket versioning
  default_lifecycle_status       = "Enabled"     # Optional. Whether default LCM rule is enabled/disabled
  transition_days_s3ia           = 30            # Optional. Number of days before objects are transitioned to IA
  transition_days_glacier        = 60            # Optional. Number of days before objects are transitioned to glacier
}
output "infrastructure" { value = module.s4pce_customer_infrastructure }
