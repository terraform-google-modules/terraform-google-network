/*
  Description: Terraform input variables
  Comments:
    - For new deployments use the new network variables instead of legacy
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### VPC Variables
customer = "EXAMPLE0001"

##### Default Tagging Variables
business                        = "ibp"
business_friendly_name          = "Integrated Business Planning"
owner                           = "EXAMPLE_OWNER_EMAIL"
organization                    = "EXAMPLE_ORGANIZATION"
organization_friendly_name      = "EXAMPLE_ORGANIZATION_FRIENDLY_NAME"
security_boundary               = "EXAMPLE_SECURITY_BOUNDARY"
security_boundary_friendly_name = "EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME"
environment                     = "EXAMPLE_ENVIRONMENT"


management_nat_name = "private-1a"

#### Legacy Network Variables
# vpc_cidr_block                    = "EXAMPLE_10.77.100.0/22"
# subnet_dataservices_1a_cidr_block = "EXAMPLE_10.77.100.0/26"
# subnet_dataservices_1b_cidr_block = "EXAMPLE_10.77.100.64/26"
# subnet_production_1a_cidr_block   = "EXAMPLE_10.77.101.0/26"
# subnet_production_1b_cidr_block   = "EXAMPLE_10.77.101.64/26"
# subnet_staging_1a_cidr_block      = "EXAMPLE_10.77.102.0/26"
# subnet_staging_1b_cidr_block      = "EXAMPLE_10.77.102.64/26"
# subnet_edge_1a_cidr_block         = "EXAMPLE_10.77.103.0/26"
# subnet_edge_1b_cidr_block         = "EXAMPLE_10.77.103.64/26"
# subnet_edge_1c_cidr_block         = "EXAMPLE_10.77.103.128/26"

# NOTE:
# * `subnet_staging_1b_cidr_block` was defined in the legacy model but never used.
# * `Edge1c` was created in legacy model but never used or given it's own NGW
# * Historical artifacts presents CIDR/22 as the default size.  There's no technical reason to follow this
# * The CIDR/24 below is possible, but leaves little room for error.
# * For now it's safer to use the example subnet names. WIP to decouple the names from automation.

#### New Network Variables
network = {
  use_new_network_model = true
  primary = {
    cidr = "10.77.100.0/24"
    subnets = {
      dataservices_1 = { zone = "a", cidr = "EXAMPLE_10.77.100.0/27" }
      dataservices_2 = { zone = "b", cidr = "EXAMPLE_10.77.100.32/27" }
      production_1   = { zone = "a", cidr = "EXAMPLE_10.77.100.64/27" }
      production_2   = { zone = "b", cidr = "EXAMPLE_10.77.100.96/27" }
      staging_1      = { zone = "a", cidr = "EXAMPLE_10.77.100.128/27" }
    }
    subnets_edge = {
      edge_1 = { zone = "a", cidr = "EXAMPLE_10.77.100.160/27" }
      edge_2 = { zone = "b", cidr = "EXAMPLE_10.77.100.192/27" }
    }
  }
}



##### Define these in your local.auto.tfvars
// build_user                                  = ""

adv_backup_vault_force_destroy = false
