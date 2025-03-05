/*
  Description: Terraform input variables
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

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


#### Network Variables (Original Design Specification)
vpc_cidr_block                         = "EXAMPLE_10.1.0.0/19"
subnet_production_1a_cidr_block        = "EXAMPLE_10.1.0.0/23"
subnet_production_1b_cidr_block        = "EXAMPLE_10.1.2.0/23"
subnet_production_1c_cidr_block        = "EXAMPLE_10.1.4.0/23"
subnet_quality_assurance_1a_cidr_block = "EXAMPLE_10.1.6.0/23"
subnet_quality_assurance_1b_cidr_block = "EXAMPLE_10.1.8.0/23"
subnet_quality_assurance_1c_cidr_block = "EXAMPLE_10.1.10.0/23"
subnet_development_1a_cidr_block       = "EXAMPLE_10.1.12.0/23"
subnet_development_1b_cidr_block       = "EXAMPLE_10.1.14.0/23"
subnet_development_1c_cidr_block       = "EXAMPLE_10.1.16.0/23"
subnet_edge_1a_cidr_block              = "EXAMPLE_10.1.20.0/26"
subnet_edge_1b_cidr_block              = "EXAMPLE_10.1.20.64/26"
subnet_edge_1c_cidr_block              = "EXAMPLE_10.1.20.128/26"
##### Define these in your local.auto.tfvars
// build_user                                  = ""

#### Additional AWS Endpoints
# additional_endpoints_creation = true
# additional_endpoints = ["aws_backup", "aws_certificate_manager", "aws_cloudtrail", "aws_cloudwatch_alarms", "aws_cloudwatch_logs", "aws_cloudwatch_metrics", "aws_config,aws_console", "aws_data_sync", "aws_directory_service", "aws_dynamodb,aws_ebs", "aws_ec2,aws_efs", "aws_eip,aws_elb", "aws_guardduty", "aws_iam,aws_kms", "aws_lambda", "aws_loadbalancer", "aws_private_certificate_authority_", "aws_route53", "aws_ses", "aws_site-to-site_vpn", "aws_sns", "aws_eventbridge", "aws_ssm_inventory", "aws_ssm_patching", "aws_transitgateway", "aws_vpc", "aws_vpc_flow_logs"]
