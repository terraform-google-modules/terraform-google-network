/*
  Description: Creates SFTP endpoints for the Customer
  Layer: 00
  Dependencies:
    layer-00: infrastructure
    layer-02: layer 02 outputs
  Comments: None
*/


locals {
  # Parse the instance list and creates a new list of instances where the productname is `sftp_interface`
  sftp_hosts = { for key, value in local.layer_02_outputs.raw_instance_list : key => value if lookup(value, "productname", "undefined") == "sftp_interface" }
  sftp_sids  = sort(distinct([for key, value in local.sftp_hosts : lower(value.sid) if(value.sid != null)]))
  sftp_sid_map = { for key in local.sftp_sids : key => [
    for host, hostvalue in local.sftp_hosts : merge({ key = host }, hostvalue) if lower(hostvalue.sid) == lower(key)
  ] }
  sftp_endpoints = {
    for key, value in local.sftp_sid_map : lower("${substr(value[0].key, 0, 4)}sftp${key}") => {
      nlb_subnet_list = [
        local.layer_00_outputs.infrastructure["subnet_${replace(lower(value[0].landscape), "-", "_")}_1a"].id,
        local.layer_00_outputs.infrastructure["subnet_${replace(lower(value[0].landscape), "-", "_")}_1b"].id,
        local.layer_00_outputs.infrastructure["subnet_${replace(lower(value[0].landscape), "-", "_")}_1c"].id,
      ]
      nlb_name             = "${local.base_context.customer}-${lower(key)}-sftp"
      nlb_port_list        = ["8022"]
      nlb_target_id        = [for host in value : local.layer_02_outputs.instance_list[host.key].instance_id]
      endpoint_edge_vpc_id = aws_vpc.main01.id
      endpoint_security_group_list = [
        aws_security_group.main01_all_egress.id,
        aws_security_group.main01_ingress.id
      ]
      endpoint_subnet_list = [
        aws_subnet.main01_infrastructure_1a.id,
        aws_subnet.main01_infrastructure_1b.id,
        aws_subnet.main01_infrastructure_1c.id,
      ]
    }
  }
}

# This module creates NLB's in the backend that have a dynamic list of listeners and targegroups
# from the NLB's, endpoint services are created. Endpoints are then created to consume the Endpoint service.
module "sftp_endpoints" {
  for_each                     = local.sftp_endpoints
  source                       = "../../EXAMPLE_SOURCE/terraform/s4pce/modules/terraform-aws-endpoint-multiport-multitarget"
  context                      = module.base_layer_context.context
  nlb_subnet_list              = each.value.nlb_subnet_list
  nlb_name                     = each.value.nlb_name
  nlb_port_list                = each.value.nlb_port_list
  nlb_target_id                = each.value.nlb_target_id
  endpoint_edge_vpc_id         = each.value.endpoint_edge_vpc_id
  endpoint_security_group_list = each.value.endpoint_security_group_list
  endpoint_subnet_list         = each.value.endpoint_subnet_list
}
