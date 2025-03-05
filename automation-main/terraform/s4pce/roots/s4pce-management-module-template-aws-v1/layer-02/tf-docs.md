# layer-02

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
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
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_rhel"></a> [context\_instance\_rhel](#module\_context\_instance\_rhel) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_ubuntu"></a> [context\_instance\_ubuntu](#module\_context\_instance\_ubuntu) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_instance_windows"></a> [context\_instance\_windows](#module\_context\_instance\_windows) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_context_key_pair_main01"></a> [context\_key\_pair\_main01](#module\_context\_key\_pair\_main01) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context | n/a |
| <a name="module_instance_bastion"></a> [instance\_bastion](#module\_instance\_bastion) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_hana_cockpit"></a> [instance\_hana\_cockpit](#module\_instance\_hana\_cockpit) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_nginx_proxy"></a> [instance\_nginx\_proxy](#module\_instance\_nginx\_proxy) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_openvpn_mfa"></a> [instance\_openvpn\_mfa](#module\_instance\_openvpn\_mfa) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_ses_postfix_host"></a> [instance\_ses\_postfix\_host](#module\_instance\_ses\_postfix\_host) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_solman_abap"></a> [instance\_solman\_abap](#module\_instance\_solman\_abap) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_solman_hana"></a> [instance\_solman\_hana](#module\_instance\_solman\_hana) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |
| <a name="module_instance_solman_java"></a> [instance\_solman\_java](#module\_instance\_solman\_java) | EXAMPLE_SOURCE/terraform/shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_plan) | resource |
| [aws_backup_selection.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_selection) | resource |
| [aws_backup_vault.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/backup_vault) | resource |
| [aws_key_pair.main01](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/key_pair) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/caller_identity) | data source |
| [aws_kms_alias.ec2_backups](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/data-sources/kms_alias) | data source |
| [terraform_remote_state.layer_00](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.layer_01](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `any` | n/a | yes |
| <a name="input_backup_metadata"></a> [backup\_metadata](#input\_backup\_metadata) | Management Backup Metadata | <pre>object({<br/>    schedule              = optional(string, "cron(0 5 ? * 7 *)")<br/>    frequency_description = optional(string, "Weekly at midnight on Fridays")<br/>    completion_window     = optional(number, 720)<br/>    delete_after          = optional(number, 90)<br/>    selection_name        = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User id of individual executing terraform; must be defined for auditing purposes. | `any` | n/a | yes |
| <a name="input_image_metadata"></a> [image\_metadata](#input\_image\_metadata) | Metadata for images to search for | <pre>object({<br/>    database_image    = string<br/>    application_image = string<br/>    openvpn_image     = string<br/>    base_image        = string<br/>  })</pre> | n/a | yes |
| <a name="input_image_owner_default"></a> [image\_owner\_default](#input\_image\_owner\_default) | Default AMI Owner to use | `string` | `"156506675147"` | no |
| <a name="input_ssh_management_public_key"></a> [ssh\_management\_public\_key](#input\_ssh\_management\_public\_key) | SSH public key to create an AWS EC2 Key from and associate with management instances | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_bastion"></a> [instance\_bastion](#output\_instance\_bastion) | n/a |
| <a name="output_instance_hana_cockpit"></a> [instance\_hana\_cockpit](#output\_instance\_hana\_cockpit) | n/a |
| <a name="output_instance_openvpn"></a> [instance\_openvpn](#output\_instance\_openvpn) | #### Instances |
| <a name="output_instance_ses_postfix_host"></a> [instance\_ses\_postfix\_host](#output\_instance\_ses\_postfix\_host) | n/a |
| <a name="output_instance_solman_abap"></a> [instance\_solman\_abap](#output\_instance\_solman\_abap) | n/a |
| <a name="output_instance_solman_hana"></a> [instance\_solman\_hana](#output\_instance\_solman\_hana) | n/a |
| <a name="output_instance_solman_java"></a> [instance\_solman\_java](#output\_instance\_solman\_java) | n/a |
| <a name="output_key_pair_main01"></a> [key\_pair\_main01](#output\_key\_pair\_main01) | #### Key Pairs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
