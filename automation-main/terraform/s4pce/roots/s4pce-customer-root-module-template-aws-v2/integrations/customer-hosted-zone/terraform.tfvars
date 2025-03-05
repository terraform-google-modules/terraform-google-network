/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### Customer Private Hosted Zone
customer_hosted_zones = [
  "xyzexample.com",
]
customer_dns_map = {
  record1 = { type = "A", data = ["192.168.0.1"], zone = "xyzexample.com" }
  record2 = { type = "A", data = ["192.168.0.2"], zone = "xyzexample.com" }
}

##### Add these values to your local.auto.tfvars
// build_user                                  = ""
