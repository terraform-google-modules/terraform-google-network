# _opt_splunk

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_health_splkoncall_logic_app"></a> [health\_splkoncall\_logic\_app](#module\_health\_splkoncall\_logic\_app) | EXAMPLE_SOURCE/terraform/shared/modules/terraform-azure-health-splkoncall-logic-app | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_action_group.actiongrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_activity_log_alert.alert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_activity_log_alert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_splunk_on_call_url"></a> [splunk\_on\_call\_url](#input\_splunk\_on\_call\_url) | splunk on call url | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
