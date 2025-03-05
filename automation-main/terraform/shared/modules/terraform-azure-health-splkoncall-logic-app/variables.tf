variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "logic_app_name" {
  type        = string
  description = "Logic app Name"
}

variable "logic_app_name_action_name" {
  type        = string
  description = "logic app action name"
}

variable "region" {
  type        = string
  description = "Name of the region"
}

variable "splunk_on_call_url" {
  type        = string
  description = "splunk on call url"
}
