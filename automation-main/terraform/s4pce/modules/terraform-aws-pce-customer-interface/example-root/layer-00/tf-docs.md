# layer-00

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_context"></a> [base\_context](#module\_base\_context) | ../../../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_route_table) | resource |
| [aws_default_security_group.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/default_security_group) | resource |
| [aws_efs_file_system.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/efs_mount_target) | resource |
| [aws_internet_gateway.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/internet_gateway) | resource |
| [aws_route.test_service_vpc_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_subnet.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/subnet) | resource |
| [aws_vpc.test_service_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_test_efs"></a> [test\_efs](#output\_test\_efs) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
