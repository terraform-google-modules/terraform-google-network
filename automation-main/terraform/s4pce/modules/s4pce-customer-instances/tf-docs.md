<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_context_aws_security_group_saprouter"></a> [context\_aws\_security\_group\_saprouter](#module\_context\_aws\_security\_group\_saprouter) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_list"></a> [context\_instance\_list](#module\_context\_instance\_list) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_rhel"></a> [context\_instance\_rhel](#module\_context\_instance\_rhel) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_ubuntu"></a> [context\_instance\_ubuntu](#module\_context\_instance\_ubuntu) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_windows"></a> [context\_instance\_windows](#module\_context\_instance\_windows) | ../../../shared/modules/terraform-null-context | n/a |
| <a name="module_instance_list"></a> [instance\_list](#module\_instance\_list) | ../../../shared/modules/aws-instance | n/a |
| <a name="module_instance_saprouter"></a> [instance\_saprouter](#module\_instance\_saprouter) | ../../../shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.saprouter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.saprouter_standard_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.edge1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.customer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_owner_default"></a> [ami\_owner\_default](#input\_ami\_owner\_default) | Default AMI Owner to use | `string` | `"156506675147"` | no |
| <a name="input_context"></a> [context](#input\_context) | context | `any` | `null` | no |
| <a name="input_ha_instances"></a> [ha\_instances](#input\_ha\_instances) | Used to disable source/destination checking on HA instances | `list(string)` | `[]` | no |
| <a name="input_image_application_name"></a> [image\_application\_name](#input\_image\_application\_name) | Search string for SAP Application image | `string` | n/a | yes |
| <a name="input_image_database_name"></a> [image\_database\_name](#input\_image\_database\_name) | Search string for Database image | `string` | n/a | yes |
| <a name="input_instance_iam_role"></a> [instance\_iam\_role](#input\_instance\_iam\_role) | IAM role to attach to the instance | `any` | n/a | yes |
| <a name="input_instance_list"></a> [instance\_list](#input\_instance\_list) | A map of instances to create | `any` | `null` | no |
| <a name="input_instance_route53_zone_id"></a> [instance\_route53\_zone\_id](#input\_instance\_route53\_zone\_id) | route53 zone id for instances | `any` | n/a | yes |
| <a name="input_instance_security_groups_list"></a> [instance\_security\_groups\_list](#input\_instance\_security\_groups\_list) | list of security groups to attach to the instances | `any` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Map of Networks and Subnets. A primary network is required | <pre>map(<br>    object({                                   // network human-readable name. Requires a "primary"<br>      cidr      = string                       // network cidr<br>      primary_landscape = string // Primary deployment landscape. Must be contained within the subnet name. Ex: primary_landscape='production' requires subnet_name='production*'"<br>      landscape_default_deployment_zones = map(<br>        object({                // landscape name<br>          default_zone = string // default subnet zone for the landscape<br>        })<br>      )<br>      subnets = optional(<br>        map( // subnet human-readable name<br>          object({                               // Subnet name (must contain the landscape name)<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone<br>          })<br>      ), null)<br>      subnets_edge = optional( // This will be the egress subnet for NGWs and Routes.<br>        map(                   // subnet human-readable name<br>          object({<br>            cidr        = string                 // subnet cidr<br>            zone        = string                 // subnet zone.  Each Edge Zone must be unique<br>          })<br>  ), null) }))</pre> | n/a | yes |
| <a name="input_rhel_patch_group"></a> [rhel\_patch\_group](#input\_rhel\_patch\_group) | rhel patch group | `any` | n/a | yes |
| <a name="input_saprouter_ingress_cidr"></a> [saprouter\_ingress\_cidr](#input\_saprouter\_ingress\_cidr) | Allowed Ingress for SAP Router | `list(string)` | <pre>[<br>  "194.39.131.34/32"<br>]</pre> | no |
| <a name="input_ssh_keypair_name"></a> [ssh\_keypair\_name](#input\_ssh\_keypair\_name) | AWS Keypair Name | `string` | `null` | no |
| <a name="input_ssh_main01_public_key"></a> [ssh\_main01\_public\_key](#input\_ssh\_main01\_public\_key) | SSH public key to create an AWS EC2 Key from and associate with management instances | `any` | n/a | yes |
| <a name="input_ubuntu_patch_group"></a> [ubuntu\_patch\_group](#input\_ubuntu\_patch\_group) | ubuntu patch group | `any` | n/a | yes |
| <a name="input_windows_patch_group"></a> [windows\_patch\_group](#input\_windows\_patch\_group) | windows patch group | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_list"></a> [instance\_list](#output\_instance\_list) | ##### Instances |
| <a name="output_key_pair_name"></a> [key\_pair\_name](#output\_key\_pair\_name) | n/a |
| <a name="output_raw_instance_list"></a> [raw\_instance\_list](#output\_raw\_instance\_list) | n/a |
<!-- END_TF_DOCS -->