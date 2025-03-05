output "logic_app_id" {
  value = azurerm_logic_app_trigger_http_request.logic_app_http_request.id
}

output "logic_app_name" {
  value = azurerm_logic_app_trigger_http_request.logic_app_http_request.name
}

output "callback_url" {
  value = azurerm_logic_app_trigger_http_request.logic_app_http_request.callback_url
}
