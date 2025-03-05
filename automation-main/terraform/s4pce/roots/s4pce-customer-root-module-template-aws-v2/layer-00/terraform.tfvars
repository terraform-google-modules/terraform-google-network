/*
  Description: Terraform input variables
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### Add the following to your local.auto.tfvars
// build_user = ""

##### Default Tagging Variables
organization                    = "EXAMPLE_ORGANIZATION"
organization_friendly_name      = "EXAMPLE_ORGANIZATION_FRIENDLY_NAME"
security_boundary               = "EXAMPLE_SECURITY_BOUNDARY"
security_boundary_friendly_name = "EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME"
business                        = "s4"
business_subsection             = "pce"
business_friendly_name          = "S4 Private Cloud Edition"
owner                           = "EXAMPLE_OWNER_EMAIL"
environment                     = "EXAMPLE_ENVIRONMENT"
customer                        = "EXAMPLE0001"

#### New Network Variables
network = {
  primary = {
    primary_landscape = "production"
    landscape_default_deployment_zones = {
      production        = { default_zone = "a" }
      quality_assurance = { default_zone = "b" }
      development       = { default_zone = "c" }
    }
    cidr = "EXAMPLE_10.1.0.0/19"
    subnets = {
      production_1        = { zone = "a", cidr = "EXAMPLE_10.1.0.0/23" }
      production_2        = { zone = "b", cidr = "EXAMPLE_10.1.2.0/23" }
      production_3        = { zone = "c", cidr = "EXAMPLE_10.1.4.0/23" }
      quality_assurance_1 = { zone = "a", cidr = "EXAMPLE_10.1.6.0/23" }
      quality_assurance_2 = { zone = "b", cidr = "EXAMPLE_10.1.8.0/23" }
      quality_assurance_3 = { zone = "c", cidr = "EXAMPLE_10.1.10.0/23" }
      development_1       = { zone = "a", cidr = "EXAMPLE_10.1.12.0/23" }
      development_2       = { zone = "b", cidr = "EXAMPLE_10.1.14.0/23" }
      development_3       = { zone = "c", cidr = "EXAMPLE_10.1.16.0/23" }
    }
    subnets_edge = {
      edge_1 = { zone = "a", cidr = "EXAMPLE_10.1.20.0/26" }
      edge_2 = { zone = "b", cidr = "EXAMPLE_10.1.20.64/26" }
      edge_3 = { zone = "c", cidr = "EXAMPLE_10.1.20.128/26" }
    }
  }
}
# custom_no_nat_gateways = ""
# custom_no_local_dns_zone = ""
# custom_efs_throughput_mode = ""
# custom_efs_throughput_in_mibps = ""

#### Additional AWS Endpoints
# additional_endpoints_creation = true
# additional_endpoints = ["aws_backup", "aws_certificate_manager", "aws_cloudtrail", "aws_cloudwatch_alarms", "aws_cloudwatch_logs", "aws_cloudwatch_metrics", "aws_config,aws_console", "aws_data_sync", "aws_directory_service", "aws_dynamodb,aws_ebs", "aws_ec2,aws_efs", "aws_eip,aws_elb", "aws_guardduty", "aws_iam,aws_kms", "aws_lambda", "aws_loadbalancer", "aws_private_certificate_authority_", "aws_route53", "aws_ses", "aws_site-to-site_vpn", "aws_sns", "aws_eventbridge", "aws_ssm_inventory", "aws_ssm_patching", "aws_transitgateway", "aws_vpc", "aws_vpc_flow_logs"]

#### HA Variables
deploy_ha_efs = false
