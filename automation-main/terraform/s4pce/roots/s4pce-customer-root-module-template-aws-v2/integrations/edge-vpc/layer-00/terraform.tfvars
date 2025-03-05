/*
  Description: Terraform layer-00 input variables; Universal variables for CRE SMS Management layer-00 infrastructure
  Layer: 00
  Comments:
    - Rename this file to terraform.tfvars to use
    - Uncomment and populate the missing variables before use
    - 'vpc_prefix' should be a unique naming prefix globally in the account
    - 'vpc_cidr_block' and all associated subnets should have unique CIDR blocks in the account
*/

### AWS Variables
aws_region = "EXAMPLE_REGION"

### Networking Variables
vpc_cidr_block                             = "172.16.0.0/16"
vpc_ingress_cidr_list                      = ["0.0.0.0/0"]
subnet_main01_infrastructure_1a_cidr_block = "172.16.1.0/24"
subnet_main01_infrastructure_1b_cidr_block = "172.16.2.0/24"
subnet_main01_infrastructure_1c_cidr_block = "172.16.3.0/24"
vgw_asn                                    = "64512"

### Endpoint Map
ha_endpoints = {
  # t0001ha01 = {
  #   vhost   = ""
  #   address = ""
  # }
}

loadbalancer_names = [
  # "unqiue_loadbalancer_name",
]

### Uncomment and populate these values before running terraform
// build_user = ""
