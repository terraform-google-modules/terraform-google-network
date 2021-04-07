output "route_name" {
  value       = module.google_compute_route.google_compute_route.route
  description = "The name of the route being created"
}

