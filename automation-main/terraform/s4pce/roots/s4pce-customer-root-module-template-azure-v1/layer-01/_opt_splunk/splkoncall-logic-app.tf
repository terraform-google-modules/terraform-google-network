/*
Description: Resources for Splunk Monitoring
*/

variable "splunk_on_call_url" {
  type        = string
  description = "splunk on call url"
}

module "health_splkoncall_logic_app" {
  source                     = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-azure-health-splkoncall-logic-app"
  resource_group_name        = local.layer_00.infrastructure.resource_group_customer.name
  logic_app_name             = "${split("/", var.root_module)[3]}-splunkoncall-lgapp"
  logic_app_name_action_name = "When_a_HTTP_request_is_received"
  region                     = var.azure_region
  splunk_on_call_url         = var.splunk_on_call_url
}

resource "azurerm_monitor_action_group" "actiongrp" {
  name                = "${split("/", var.root_module)[3]}-splunkoncall-actiongrp"
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  short_name          = "${substr(split("/", var.root_module)[3], 0, 1)}${replace(split("/", var.root_module)[3], "/[A-Za-z]/", "")}acgrp"

  logic_app_receiver {
    name                    = module.health_splkoncall_logic_app.logic_app_name
    resource_id             = module.health_splkoncall_logic_app.logic_app_id
    callback_url            = module.health_splkoncall_logic_app.callback_url
    use_common_alert_schema = true
  }

  depends_on = [module.health_splkoncall_logic_app]

}

resource "azurerm_monitor_activity_log_alert" "alert" {
  name                = "${split("/", var.root_module)[3]}-splunkoncall-logalert"
  resource_group_name = local.layer_00.infrastructure.resource_group_customer.name
  scopes              = [local.layer_00.infrastructure.resource_group_customer.id]

  criteria {
    category = "ResourceHealth"
  }

  action {
    action_group_id = azurerm_monitor_action_group.actiongrp.id
  }

  depends_on = [azurerm_monitor_action_group.actiongrp]
}
