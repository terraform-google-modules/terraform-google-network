# example-root

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoint_test_443"></a> [endpoint\_test\_443](#module\_endpoint\_test\_443) | ../../../modules/aws-endpoint-services | n/a |
| <a name="module_endpoint_test_80"></a> [endpoint\_test\_80](#module\_endpoint\_test\_80) | ../../../modules/aws-endpoint-services | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.test_consumer_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_route_table.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.test_consumer_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_default_security_group.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/instance) | resource |
| [aws_internet_gateway.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/internet_gateway) | resource |
| [aws_key_pair.key_pair](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_route.test_service_vpc_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_subnet.test_consumer_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_subnet.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.test_consumer_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_vpc.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [tls_private_key.keygen](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [aws_ami.instance](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where the module is run | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | Employee ID that is running the terraform code | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_443_results"></a> [endpoint\_443\_results](#output\_endpoint\_443\_results) | n/a |
| <a name="output_endpoint_80_results"></a> [endpoint\_80\_results](#output\_endpoint\_80\_results) | n/a |
| <a name="output_test_privatekey"></a> [test\_privatekey](#output\_test\_privatekey) | n/a |
| <a name="output_test_publickey"></a> [test\_publickey](#output\_test\_publickey) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
