# layer-02

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
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
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_instance_rhel"></a> [context\_instance\_rhel](#module\_context\_instance\_rhel) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_instance_ubuntu"></a> [context\_instance\_ubuntu](#module\_context\_instance\_ubuntu) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_instance_windows"></a> [context\_instance\_windows](#module\_context\_instance\_windows) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_instance_map"></a> [instance\_map](#module\_instance\_map) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cpids_internal](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/acm_certificate) | resource |
| [aws_key_pair.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_lb.cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb) | resource |
| [aws_lb_listener.cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_route53_record.cpids](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/route53_record) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.management_layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `any` | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_cpids_lb_subnets"></a> [cpids\_lb\_subnets](#input\_cpids\_lb\_subnets) | Subnet (key) where to create cpids loadbalancers. Key matches subnet created in layer-00. Restrict one mount target per zone. | `list(string)` | <pre>[<br/>  "dataservices_1",<br/>  "dataservices_2"<br/>]</pre> | no |
| <a name="input_git_name"></a> [git\_name](#input\_git\_name) | Git username to download repositories; define if performing bootstrap through userdata. | `any` | n/a | yes |
| <a name="input_git_token"></a> [git\_token](#input\_git\_token) | Git token to download repositories; define if performing bootstrap through userdata. | `any` | n/a | yes |
| <a name="input_image_application_name"></a> [image\_application\_name](#input\_image\_application\_name) | Search string for SAP Application image | `string` | n/a | yes |
| <a name="input_image_application_owner"></a> [image\_application\_owner](#input\_image\_application\_owner) | Owner for SAP Application AMI | `string` | `"156506675147"` | no |
| <a name="input_image_database_name"></a> [image\_database\_name](#input\_image\_database\_name) | Search string for Database image | `string` | n/a | yes |
| <a name="input_image_database_owner"></a> [image\_database\_owner](#input\_image\_database\_owner) | Owner for Database AMI | `string` | `"156506675147"` | no |
| <a name="input_instance_map"></a> [instance\_map](#input\_instance\_map) | A map of instances to create. See instance.auto.tfvars for default example. | <pre>map(object({<br/>    metadata_key    = string<br/>    image_type      = string<br/>    subnet_lookup   = string<br/>    tag_name        = string<br/>    tag_description = string<br/>    instance_type   = string<br/>    cnames          = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_loadbalancer_cert_fqdn"></a> [loadbalancer\_cert\_fqdn](#input\_loadbalancer\_cert\_fqdn) | FQDN of the loadbalancer cert | `any` | n/a | yes |
| <a name="input_ssh_main01_public_key"></a> [ssh\_main01\_public\_key](#input\_ssh\_main01\_public\_key) | SSH public key to create an AWS EC2 Key from and associate with management instances | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region"></a> [aws\_region](#output\_aws\_region) | Metadata |
| <a name="output_certificate_cpids_internal_arn"></a> [certificate\_cpids\_internal\_arn](#output\_certificate\_cpids\_internal\_arn) | n/a |
| <a name="output_cpids_alb_cname"></a> [cpids\_alb\_cname](#output\_cpids\_alb\_cname) | n/a |
| <a name="output_efs_staging_ip"></a> [efs\_staging\_ip](#output\_efs\_staging\_ip) | n/a |
| <a name="output_efs_usrsaptrans_ip"></a> [efs\_usrsaptrans\_ip](#output\_efs\_usrsaptrans\_ip) | n/a |
| <a name="output_instance_cpids"></a> [instance\_cpids](#output\_instance\_cpids) | n/a |
| <a name="output_instance_map"></a> [instance\_map](#output\_instance\_map) | Instances |
| <a name="output_instance_production_ibpapp"></a> [instance\_production\_ibpapp](#output\_instance\_production\_ibpapp) | n/a |
| <a name="output_instance_production_ibpdb"></a> [instance\_production\_ibpdb](#output\_instance\_production\_ibpdb) | n/a |
| <a name="output_instance_staging_ibpapp"></a> [instance\_staging\_ibpapp](#output\_instance\_staging\_ibpapp) | n/a |
| <a name="output_instance_staging_ibpdb"></a> [instance\_staging\_ibpdb](#output\_instance\_staging\_ibpdb) | n/a |
| <a name="output_instance_webdispatcher"></a> [instance\_webdispatcher](#output\_instance\_webdispatcher) | n/a |
| <a name="output_keypair_main01"></a> [keypair\_main01](#output\_keypair\_main01) | n/a |
| <a name="output_lb_target_group_cpids_arn"></a> [lb\_target\_group\_cpids\_arn](#output\_lb\_target\_group\_cpids\_arn) | Loadbalancers |
| <a name="output_loadbalancer_cert_fqdn"></a> [loadbalancer\_cert\_fqdn](#output\_loadbalancer\_cert\_fqdn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
