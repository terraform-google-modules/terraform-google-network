Terraform AWS List Workspaces
=============================

This module provides the ability to query a list of Terraform workspaces from an AWS S3 bucket at a specified path.

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Terraform v0.13+
* `aws` CLI

Example Usage
-------------

```hcl
module "aws_list_workspaces" {
  source = "<path>/<to>/ns2-terraform/modules/terraform-aws-list-workspaces"

  s3_bucket_name = "ns2-cre-sms-terraform"
  folder_path    = "management/layer-00"
}
```

Argument Reference
------------------

* `s3_bucket_name` - (`<string>`) Name of the AWS S3 bucket
* `folder_path` - (`<string>`) _optional_, Path to folder within the AWS S3 bucket to look for a list of Terraform Workspaces

Attributes Reference
--------------------

* `workspaces` - (`<list(string)>`) returned list of current Terraform workspaces contained in the specified S3 bucket path

Author Information
------------------

* Devon Thyne [devon.thyne@sapns2.com](mailto:devon.thyne@sapns2.com)
