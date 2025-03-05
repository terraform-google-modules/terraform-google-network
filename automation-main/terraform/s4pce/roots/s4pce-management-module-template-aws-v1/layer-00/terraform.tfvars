/*
  Description: Terraform input variables
  Comments:
*/

### AWS Variables
// see workspace-tfvars for specific values

### Networking Variables
// see workspace-tfvars for specific values

### Naming and Tagging Variables
organization                    = "EXAMPLE_ORGANIZATION"
organization_friendly_name      = "EXAMPLE_ORGANIZATION_FRIENDLY_NAME"
security_boundary               = "EXAMPLE_SECURITY_BOUNDARY"
security_boundary_friendly_name = "EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME"
business                        = "s4"
business_subsection             = "pce"
business_friendly_name          = "S4 Private Cloud Edition"
owner                           = "EXAMPLE_OWNER_EMAIL"
environment                     = "EXAMPLE_ENVIRONMENT"
customer                        = "EXAMPLE_TESTING_UNIQUE_management"
label_order = [
  "security_boundary",
  "business",
  "cloud_in_country",
  "customer"
]

### Route53 Variables
// See workspace-tfvars for specific values


### Whitelisted IP Addresses
// See workspace-tfvars for specific values

### Uncomment and populate these values before running terraform
// build_user = ""
