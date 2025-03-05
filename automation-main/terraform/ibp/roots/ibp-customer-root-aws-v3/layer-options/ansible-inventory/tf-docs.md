# ansible-inventory

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.file_content](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_inventory_vars"></a> [inventory\_vars](#input\_inventory\_vars) | Additional variables used to generate Ansible Inventory | <pre>object({<br/>    staging_sid           = string<br/>    production_sid        = string<br/>    customer_number       = string<br/>    input_hostfile_fqdn   = string<br/>    webdispatcher_release = string<br/>    cpids_release         = string<br/>    prod_release          = string<br/>    nonprod_release       = string<br/>  })</pre> | <pre>{<br/>  "cpids_release": "___EXAMPLE_GOLD-PRD-CPIDS-DSOD-9.9.99.99-TAR-V99___",<br/>  "customer_number": "___EXAMPLE_99___",<br/>  "input_hostfile_fqdn": "___EXAMPLE.IBP.REGION.SCS.INTERNAL___",<br/>  "nonprod_release": "___EXAMPLE_GOLD-NONPRD-9999-HFC99-EP99-TAR-V1___",<br/>  "prod_release": "___EXAMPLE_GOLD-PRD-9999-HFC99-EP99-TAR-V1___",<br/>  "production_sid": "___EXAMPLE_99___",<br/>  "staging_sid": "___EXAMPLE_99___",<br/>  "webdispatcher_release": "___EXAMPLE_WDISP_REL99_PL99_TAR_V99___"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zzz_ansible_inventory"></a> [zzz\_ansible\_inventory](#output\_zzz\_ansible\_inventory) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
