/*
  Description: TFVars file for Directory Service Module.
  Notes: Add this to your layer-options compatible root module to create an AWS Directory Service.
*/


directory_service_create_options = {
  cloudwatch_log_group             = true
  workspace_fullaccess_policy      = false
  constrained_endpoint             = false
  constrained_endpoint_dns_records = false
  outbound_resolver                = true
}

directory_service_config = {
  netbios        = "test"
  admin_password = "Password123!"
  fqdn           = "test.internal"
}

# Recommended. Pass in two CIDR Ranges for subnet creation in different AZs.
directory_service_subnet_config = {
  az1a = { cidr_block = "999.88.7.0/24", az = "___AWS_REGION_A___" }
  az1b = { cidr_block = "999.88.6.0/24", az = "___AWS_REGION_B___" }
}
# Not Recommended.  Pass in blank to reuse existing subnets
# directory_service_subnet_config = {}
