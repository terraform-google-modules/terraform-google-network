azure-endpoint-services-multiport Module
========================================

This module extracts host/vpc endpoint from the output of existing infrastructure (s4-pce) remote state files and generate a markdown file.

**Table of Contents:**

[[_TOC_]]

Dependencies
------------

* Terraform 0.14+

Module Variables
----------------

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| generated_file_name | | (**Required**) name for the generated file | |
| customer_name | | (**Required**) customer name | |
| endpoint_list | | (**Optional**)  endpoint list from edge vpc| |
| raw_list | | (**Optional**)  raw instance list from infrastructure layer| |




Sample usage:

```
module "processor" {
  source              = "../"
  customer_name       = local.customer_name
  generated_file_name = "${path.module}/pce-${local.customer_name}.txt"
  endpoint_list       = data.terraform_remote_state.edge_vpc.outputs.endpoint_list
  raw_list            = data.terraform_remote_state.instances.outputs.raw_instance_list
}
```

File content generated from sample:
## testing0001
| Record                | Type  | Data |
| --------------------- | ----- | ---- |
|  NS2B4QAPP            | CNAME |  vpce-0f636904fc3284acb-mrtb59ob.vpce-svc-06ec4078c14785cb4.us-gov-west-1.vpce.amazonaws.com  |
|  NS2BDQAPP            | CNAME |  vpce-08c4748148a205638-x7lqjghc.vpce-svc-08ed899ffee6e2aa5.us-gov-west-1.vpce.amazonaws.com  |
|  t001app01ps4            | CNAME |  vpce-015558f8c5ea30f4a-jogh37b0.vpce-svc-00a66e6c1c55c6967.us-gov-west-1.vpce.amazonaws.com  |

Author Information
------------------

* Jian Ouyang (jian.ouyang@sapns2.com)
