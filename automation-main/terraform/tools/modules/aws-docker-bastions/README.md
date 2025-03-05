# aws-docker-bastions Module

Creates any number of Ubuntu Images with the following:
* Adjustable Subnet Placement
* Optional Public IP
* Bootstrapped to install docker
* NOTE: Bootstrapping may take up to 10 minutes to complete.

## Dependencies
* See [tf-docs](./tf-docs.md) for terraform dependencies

## Example
* See [module-test](./example_root/module-test.tf) for more detailed example

```hcl
module "module_test" {
  source              = "../"
  tags                = var.tags
  key_name            = aws_key_pair.key.key_name
  docker_bastion_list = ["user1", "user2"]
  subnet_id           = var.subnet_id
  image_ubuntu        = var.image_ubuntu_id
  security_groups     = [var.security_group1_id, var.security_group2_id]
}
```
