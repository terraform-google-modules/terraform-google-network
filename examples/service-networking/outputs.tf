output "project_id" {
  description = "Project ID"
  value       = var.project_id
}

output "peering" {
  description = "Service networking peering output"
  value       = module.service_networking.peering
}
