/*
  Description: Terraform input variables
  Comments:
*/

### AWS Variables
aws_region = "EXAMPLE_REGION"

### Networking Variables
vpc_cidr_block        = "EXAMPLE_10.50.0.0/23"
tenant_vpc_cidr_block = ["EXAMPLE_10.51.0.0/16"]
// Reserved subnet cidr block - OpenVPN pool for connected clients
// subnet_main01_vpn_pool_cidr_block         = "EXAMPLE_10.50.0.64/26"
subnet_main01_infrastructure_1a_cidr_block = "EXAMPLE_10.50.0.0/27"
subnet_main01_infrastructure_1b_cidr_block = "EXAMPLE_10.50.0.32/27"
subnet_main01_infrastructure_1c_cidr_block = "EXAMPLE_10.50.0.64/27"
subnet_main01_edge_1a_cidr_block           = "EXAMPLE_10.50.0.96/27"
subnet_main01_edge_1b_cidr_block           = "EXAMPLE_10.50.0.128/27"
subnet_main01_edge_1c_cidr_block           = "EXAMPLE_10.50.0.160/27"

### Naming and Tagging Variables

cloud_in_country = {
  name     = "east", formatted = "east"
  friendly = "east"
}

### Route53 Variables
dns_fqdn = "east.EXAMPLE_INTERNAL_FQDN"
dns_authorization_vpc_ids = [
  #   { vpc_id = "EXAMPLE_VPC_ID", region = "EXAMPLE_REGION", description = "EXAMPLE VPC in another account to authorize" },
]
dns_external_fqdn = "" # Optional, Leave empty if not needed

### Whitelisted IP Addresses
whitelisted_ip_addresses = {
  //  "0.0.0.0/0": "Temporary Allow All"
}
