# directory-service Module

Deploys an AWS Directory Service with the following optional additions:
* cloudwatch_log_group
* workspace_fullaccess_policy (IAM)
* constrained_endpoint (EC2 Instance)
* constrained_endpoint_dns_records
* outbound_resolver (Route53 Resolver Endpoint and Rule)

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl

module "test" {
  source                                  = "../"
  tags                                    = local.tags
  create_cloudwatch_log_group             = false
  create_workspace_fullaccess_policy      = false
  create_constrained_endpoint             = false
  create_constrained_endpoint_dns_records = false
  create_outbound_resolver                = false

  directory_service        = {
    netbios        = "test"
    admin_password = "Password123!"
    fqdn           = "test.internal"
  }
  directory_service_vpc_id = "vpc_id"
  directory_service_subnets = {
    import_subnet_ids = ["subnet1_id", "subnet2_id"]
  }
}
```
