# audit-vpn

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.4.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_main01_vpn_ingress"></a> [context\_aws\_security\_group\_main01\_vpn\_ingress](#module\_context\_aws\_security\_group\_main01\_vpn\_ingress) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_rhel"></a> [context\_instance\_rhel](#module\_context\_instance\_rhel) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_key_pair_main01"></a> [context\_key\_pair\_main01](#module\_context\_key\_pair\_main01) | ../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_instance_openvpn"></a> [instance\_openvpn](#module\_instance\_openvpn) | ../../EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/internet_gateway) | resource |
| [aws_key_pair.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_route.main01_default_route_igw](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route) | resource |
| [aws_security_group.main01_vpn_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.main01_vpn_ingress_intra_vpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_vpn_ingress_ssh](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.main01_vpn_ingress_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/partition) | data source |
| [terraform_remote_state.edge_vpc_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_02](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_owner_default"></a> [ami\_owner\_default](#input\_ami\_owner\_default) | Default AMI Owner to use | `string` | `"156506675147"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_image_openvpn_name"></a> [image\_openvpn\_name](#input\_image\_openvpn\_name) | Search string for OpenVPN image | `string` | n/a | yes |
| <a name="input_ssh_auditor_key"></a> [ssh\_auditor\_key](#input\_ssh\_auditor\_key) | SSH public key to create an AWS EC2 Key from and associate with auditor instances | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_openvpn"></a> [instance\_openvpn](#output\_instance\_openvpn) | ## Instances |
| <a name="output_internet_gateway_main01"></a> [internet\_gateway\_main01](#output\_internet\_gateway\_main01) | ## Gateway |
| <a name="output_key_pair_main01"></a> [key\_pair\_main01](#output\_key\_pair\_main01) | ## KeyPairs |
| <a name="output_security_group_main01_vpn_ingress"></a> [security\_group\_main01\_vpn\_ingress](#output\_security\_group\_main01\_vpn\_ingress) | ## Routes ## Security Groups |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
