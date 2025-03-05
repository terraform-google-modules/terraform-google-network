resource "azurerm_logic_app_workflow" "logic_app_creation" {
  name                = var.logic_app_name
  location            = var.region
  resource_group_name = var.resource_group_name
}

resource "azurerm_logic_app_trigger_http_request" "logic_app_http_request" {
  name         = var.logic_app_name_action_name
  logic_app_id = azurerm_logic_app_workflow.logic_app_creation.id

  schema = <<SCHEMA
{
    "method": "POST",
    "type": "object",
    "properties": {
        "alertContext": {
            "properties": {
                "Activity Log Event Description": {},
                "channels": {
                    "type": "string"
                },
                "correlationId": {
                    "type": "string"
                },
                "eventDataId": {
                    "type": "string"
                },
                "eventSource": {
                    "type": "string"
                },
                "eventTimestamp": {
                    "type": "string"
                },
                "level": {
                    "type": "string"
                },
                "operationId": {
                    "type": "string"
                },
                "operationName": {
                    "type": "string"
                },
                "properties": {
                    "properties": {
                        "cause": {
                            "type": "string"
                        },
                        "currentHealthStatus": {
                            "type": "string"
                        },
                        "details": {},
                        "previousHealthStatus": {
                            "type": "string"
                        },
                        "title": {
                            "type": "string"
                        },
                        "type": {
                            "type": "string"
                        }
                    },
                    "type": "object"
                },
                "status": {
                    "type": "string"
                },
                "submissionTimestamp": {
                    "type": "string"
                }
            },
            "type": "object"
        },
        "essentials": {
            "properties": {
                "alertContextVersion": {
                    "type": "string"
                },
                "alertId": {
                    "type": "string"
                },
                "alertRule": {
                    "type": "string"
                },
                "alertTargetIDs": {
                    "items": {
                        "type": "string"
                    },
                    "type": "array"
                },
                "configurationItems": {
                    "items": {
                        "type": "string"
                    },
                    "type": "array"
                },
                "description": {
                    "type": "string"
                },
                "essentialsVersion": {
                    "type": "string"
                },
                "firedDateTime": {
                    "type": "string"
                },
                "monitorCondition": {
                    "type": "string"
                },
                "monitoringService": {
                    "type": "string"
                },
                "originAlertId": {
                    "type": "string"
                },
                "severity": {
                    "type": "string"
                },
                "signalType": {
                    "type": "string"
                }
            },
            "type": "object"
        }
    }
}
SCHEMA

}

resource "azurerm_logic_app_action_http" "logic_app_http_configuration" {
  name         = "HTTP"
  logic_app_id = azurerm_logic_app_workflow.logic_app_creation.id
  method       = "POST"
  uri          = var.splunk_on_call_url
  body         = <<BODY
  {
    "entity_id": "Azure: @{triggerBody()?['data']?['essentials']?['monitoringService']} Issue on @{first(triggerBody()?['data']?['essentials']?['configurationItems'])} customer @{first(split(triggerBody()?['data']?['essentials']?['alertRule'],'-'))}",
    "message_type": "@if(equals(triggerBody()?['data']?['essentials']?['monitorCondition'], 'Fired'),if(not(equals(triggerBody()?['data']?['alertContext']?['properties']?['cause'], 'UserInitiated')),if(equals(triggerBody()?['data']?['alertContext']?['properties']?['currentHealthStatus'], 'Available'), 'RECOVERY', if(equals(triggerBody()?['data']?['alertContext']?['properties']?['currentHealthStatus'], 'Unavailable'), 'CRITICAL', if(equals(triggerBody()?['data']?['alertContext']?['properties']?['currentHealthStatus'], 'Degraded'),'WARNING', if(and(equals(triggerBody()?['data']?['alertContext']?['properties']?['currentHealthStatus'], 'Unknown'),equals(triggerBody()?['data']?['alertContext']?['properties']?['cause'], 'PlatformInitiated')),'CRITICAL','WARNING')))),'WARNING'),if(equals(triggerBody()?['data']?['essentials']?['monitorCondition'], 'Resolved'),'RECOVERY','INFO'))",
    "state_message": "Monitor Source: Azure\nStatus: @{triggerBody()?['data']?['alertContext']?['properties']?['currentHealthStatus']}\nAlert:  @{triggerBody()?['data']}"
  }
  BODY
}
