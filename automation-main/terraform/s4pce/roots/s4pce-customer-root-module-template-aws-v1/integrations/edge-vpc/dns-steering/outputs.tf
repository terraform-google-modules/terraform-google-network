locals {
  endpoints_output = templatefile(
    "./output-endpoints.tpl",
    {
      endpoints = module.dns_steering.records
    }
  )
}
resource "local_file" "file_content" {
  content  = local.endpoints_output
  filename = "/tmp/endpoints-${module.module_context.security_boundary}-${local.base_context.customer}.md"
}
output "zzz___Message1" { value = "Endpoint Output written to ${local_file.file_content.filename}" }
