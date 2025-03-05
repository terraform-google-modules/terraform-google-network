/*
  Description: Terraform input variables
  Comments:
*/

### AWS Variables
aws_region               = "EXAMPLE_REGION"
vpc_cidr_block           = "EXAMPLE_10.60.0.0/16" # Using Gardener Defaults of a CIDR/16
vpc_secondary_cidr_block = "EXAMPLE_10.190.0.0/20"
# Zones will be prefixed by the region. ie: "west-1a"
vpc_secondary_subnets = {
  rds_subnet_a          = { cidr = "EXAMPLE_10.190.0.0/24", zone = "a", for_rds = true }
  rds_subnet_b          = { cidr = "EXAMPLE_10.190.1.0/24", zone = "b", for_rds = true }
  rds_subnet_c          = { cidr = "EXAMPLE_10.190.2.0/24", zone = "c", for_rds = true }
  private_link_subnet_a = { cidr = "EXAMPLE_10.190.3.0/24", zone = "a" }
  private_link_subnet_b = { cidr = "EXAMPLE_10.190.4.0/24", zone = "b" }
  private_link_subnet_c = { cidr = "EXAMPLE_10.190.5.0/24", zone = "c" }
}
vpc_domain_name = "EXAMPLE_REGION.compute.internal" # NOTE: A generally usable example is provided; uncomment and modify as is needed
