/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "project_id" {
  value       = var.project_id
  description = "Project ID"
}

output "fw_policy_id" {
  value       = module.firewal_policy.fw_policy.name
  description = "Firewall policy ID"
}

output "fw_policy_parent_folder" {
  value       = module.firewal_policy.fw_policy.parent
  description = "Firewall policy parent"
}

output "fw_policy_name" {
  value       = module.firewal_policy.fw_policy.short_name
  description = "Firewall policy name"
}

output "target_associations" {
  value       = module.firewal_policy.target_associations
  description = "Firewall policy association"
}

output "rules" {
  value       = module.firewal_policy.rules
  description = "Firewall policy rules"
}

output "firewal_policy_no_rules_id" {
  value       = module.firewal_policy_no_rule.fw_policy.name
  description = "ID of Firewall policy created without any rules and association"
}

output "firewal_policy_no_rules_name" {
  value       = module.firewal_policy_no_rule.fw_policy.short_name
  description = "Name of Firewall policy created without any rules and association"
}

output "firewal_policy_no_rules_parent_folder" {
  value       = module.firewal_policy.fw_policy.parent
  description = "Firewall policy parent"
}
