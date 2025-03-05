/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"


##### Add these values to your local.auto.tfvars
// build_user                                  = ""


overlay_ip_instances = [
  { instance_key = "E001dbhp4", overlay_ip = "10.239.9.0/32" },
  { instance_key = "E001cs01ps4", overlay_ip = "10.239.9.1/32" },
  { instance_key = "E001cs02ps4", overlay_ip = "10.239.9.2/32" },
  { instance_key = "E001dbhfp", overlay_ip = "10.239.9.10/32" },
  { instance_key = "E001cs01pfs", overlay_ip = "10.239.9.11/32" },
  { instance_key = "E001cs02pfs", overlay_ip = "10.239.9.12/32" },
  { instance_key = "E001cs01pfj", overlay_ip = "10.239.9.20/32" },
  { instance_key = "E001cs02pfj", overlay_ip = "10.239.9.21/32" },
]

secondarydbs = [
  "E004dbhp4ha",
  "E004dbhfpha",
]
