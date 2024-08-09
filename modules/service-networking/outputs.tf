output "address_id" {
  description = "Global address id"
  value       = google_compute_global_address.global_address.id
}

output "peering" {
  description = "Service networking connection peering"
  value       = google_service_networking_connection.default.peering
}
