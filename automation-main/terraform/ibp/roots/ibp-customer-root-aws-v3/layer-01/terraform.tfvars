/*
  Description: Terraform input variables
  Comments: N/A
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

# NOTE: Legacy Code was hardcoded to dataservices_1.  Maintaining the selection for backwards compatibility only.
efs_subnets = ["dataservices_1", "dataservices_2"]


##### Add the following to your local.auto.tfvars
// build_user = ""
