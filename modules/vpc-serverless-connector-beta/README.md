# Terraform VPC Serverless Connector Beta

This submodule is part of the the `terraform-google-network` module. It creates the vpc serverless connector using the beta components available.

It supports creating:

- serverless connector
- serverless vpc access connector

## Usage

Basic usage of this submodule is as follows:

```hcl
module "serverless-connector" {
  source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  project_id = <PROJECT ID>
  vpc_connectors = [{
    name            = "central-serverless"
    region          = "us-central1"
    subnet_name     = "<SUBNET NAME>"
    host_project_id = "<HOST PROJECT ID>"
    machine_type    = "e2-standard-4"
    min_instances   = 2
    max_instances   = 3
  }]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs


## Outputs

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
