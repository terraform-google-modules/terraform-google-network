/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

dns_account_profile = {
  name   = "" // AWS Profile Name
  region = "" // AWS Profile Region
}

dns_steering_zone = {
  fqdn = "" // Top-Level Zone FQDN
  id   = "" // Top-Level Zone ID
}

##### Add these values to your local.auto.tfvars
// build_user                                  = ""
