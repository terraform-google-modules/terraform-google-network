/*
  Description: Outputs from Context module
  Comments:
    - N/A
*/
output "account_id" {
  value = local.account_id
}

output "additional_tags" {
  value = local.additional_tags
}

output "bucket" {
  value = local.resource_name == null ? null : join(local.delimiter, [local.organization, local.resource_name])
}

output "bucket_salted" {
  value = local.resource_name == null ? null : join(local.delimiter, [local.organization, local.resource_name, local.environment_salt])
}

output "build_user" {
  value = local.build_user
}

output "business" {
  value = local.business
}

output "common_tags" {
  value = local.common_tags
}

output "context" {
  value = local.context
}

output "custom_values" {
  value = local.custom_values
}

output "customer" {
  value = local.customer
}

output "delimiter" {
  value = local.delimiter
}

output "dependencies" {
  value = local.dependencies
}

output "description" {
  value = local.description
}

output "domain" {
  value = local.domain
}

output "environment" {
  value = local.environment
}

output "environment_values" {
  value = local.environment_values
}

output "friendly_name_tags" {
  value = local.friendly_name_tags
}

output "generated_by" {
  value = local.generated_by
}

output "kv_map" {
  value = local.lookup_map
}

output "label_order" {
  value = local.label_order
}

output "labels" {
  value = local.gcp_labels
}

output "managed_by" {
  value = local.managed_by
}

output "module" {
  value = local.module
}

output "module_values" {
  value = local.module_values
}

output "module_version" {
  value = local.module_version
}

output "name" {
  value = local.resource_name
}

output "name_prefix" {
  value = local.name_prefix
}

output "organization" {
  value = local.organization
}

output "owner" {
  value = local.owner
}

output "parent_module" {
  value = local.parent_module
}

output "parent_module_version" {
  value = local.parent_module_version
}

output "partition" {
  value = local.partition
}

output "prefix_label_mapping" {
  value = local.prefix_label_mapping
}

output "provision_date" {
  value = local.provision_date
}

output "regex_replace_chars" {
  value = local.regex_replace_chars
}

output "region" {
  value = local.region
}

output "resource_prefix" {
  value = local.resource_prefix
}

output "root_module" {
  value = local.root_module
}

output "root_name" {
  value = local.name
}

output "security_boundary" {
  value = local.security_boundary
}

output "short_resource_name" {
  value = local.short_resource_name
}

output "short_resource_prefix" {
  value = local.short_resource_prefix
}

output "tags" {
  value = local.tags
}

output "tags_known" {
  value = local.tags_known
}

output "unique_name" {
  value = local.resource_name == null ? null : join(local.delimiter, [local.organization, local.resource_name, local.environment_salt])
}

output "unique_tags" {
  value = local.unique_tags
}

output "values" {
  value = local.lookup_map
}
