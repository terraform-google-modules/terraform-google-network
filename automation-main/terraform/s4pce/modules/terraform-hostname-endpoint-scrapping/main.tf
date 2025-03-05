/**
Description: get hostname/endpoint mapping from existing state files and generate a markdown file.
*/

locals {

  #from edge VPC endpoint_list,   find elements with "endpoint"."dns_name"
  endpoint_list = { for k, v in var.endpoint_list : k => try(v.endpoint.dns_name[0], "") }


  ####if tag_customhostname is defined, use this as the hostname instead
  hostname_customhostname_pair = { for k, v in var.raw_list : k => try(v.tag_customhostname, k) }


  #### replace key in endpoint_list with corresponding value from hostname_cHostnname_list
  processed_list = { for k, v in local.endpoint_list : lookup(local.hostname_customhostname_pair, k, k) => v }


  #use template to generate a local file
  file_content = templatefile(
    "${path.module}/templates/pce.tpl",
    {
      customer_name = var.customer_name
      list          = local.processed_list
    }
  )
}

resource "local_file" "file_content" {
  content  = local.file_content
  filename = var.generated_file_name
}
