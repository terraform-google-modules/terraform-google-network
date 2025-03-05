/*
  Description: Terraform reverse_private_link_list input
  Comments:
  */

reverse_private_link_list = {
  # For Envoy Deployment, Also see required tfvars.
  # example_envoy_proxy_target = {
  #   ip_address          = "custom_dns_record.custom_fqdn"
  #   port_list           = ["80", "81"]
  #   cnames              = ["example_envoy_proxy_target"]
  #   private_hosted_zone = "example_zone"
  # }

  # example_iptables_proxy_target = {
  #   ip_address          = "192.168.0.1"
  #   port_list           = ["80", "81"]
  #   cnames              = ["example_iptables_proxy_target"]
  #   private_hosted_zone = "example_zone"
  # }
}
