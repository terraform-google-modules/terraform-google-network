/*
  Description: Use AZ cli to get the private IP addresses of the scaleset instances.
               The info will be used in Ansible inventory file.
  Comment:
*/

data "template_file" "private_ip_scripts" {
  template = file("${path.module}/templates/get_vmss_privateip.tpl")

  vars = {
    resource_group = var.resource_group_name
    subscription   = data.azurerm_subscription.current.subscription_id
    name           = format("%s-%s-scaleset", var.prefix, var.vmscaleset_name)
  }
}

data "azurerm_subscription" "current" {
}

resource "local_file" "private_ip_scripts" {
  filename   = "scripts/get_vmss_instance_private_ip.sh"
  content    = data.template_file.private_ip_scripts.rendered
  depends_on = [azurerm_linux_virtual_machine_scale_set.linux_vmss]
}

data "external" "vmss_private_ip" {
  program = ["bash", local_file.private_ip_scripts.filename]
}

output "vmss_private_ips" {
  value = data.external.vmss_private_ip.result
}
