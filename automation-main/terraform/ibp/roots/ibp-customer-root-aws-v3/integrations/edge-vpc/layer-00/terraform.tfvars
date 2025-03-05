/*
  Description: Terraform input variables
  Comments: N/A
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### Network Variables
edge_vpc_cidr              = "EXAMPLE_172.16.0.0/26" # The Customer provided cidr block reserved for NS2
edge_vpc_1a_cidr           = "EXAMPLE_172.16.0.0/27" # Half the customer cidr block reserved for AZ1a
edge_vpc_1a_az             = "EXAMPLE_REGIONa"
edge_vpc_1b_cidr           = "EXAMPLE_172.16.0.32/27" # Half the customer cidr block reserved for AZ1b
edge_vpc_1b_az             = "EXAMPLE_REGIONb"
edge_vpc_ingress_cidr_list = ["EXAMPLE_172.16.0.0/26"] # This is a list of allowed ingress cidr ranges.  This should include all possible ingress from the customer

# NOTE: Legacy Code was hardcoded to dataservices_1.  Maintaining the selection for backwards compatibility only.
endpoint_nlb_subnets = ["dataservices_1", "dataservices_2"]

##### Define these in your local.auto.tfvars
// build_user                                  = ""
