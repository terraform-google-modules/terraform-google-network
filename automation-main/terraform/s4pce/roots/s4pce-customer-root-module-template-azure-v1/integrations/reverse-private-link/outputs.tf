/*
  Description: Outputs from this module; Contains commonly used outputs needed by other modules and dependent automation
  Comments: N/A
*/

output "reverse_private_links" { value = module.endpoint_list }

#proxy server private and public ip

output "proxy_server_ip" {
  value = { for key in keys(var.reverse_private_link_list) : key => {
    public_ip  = module.proxy_vm[key].public_ip
    private_ip = module.proxy_vm[key].private_ip
    }
  }
}
