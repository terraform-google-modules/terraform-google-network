/*
  Description: update route table with overlay ip routing rules
  Layer: 02
  Comments: N/A
  */


resource "aws_route" "overlay_ip" {
  for_each               = local.overlay_ip_map
  route_table_id         = local.layer_00_outputs.infrastructure.route_table[each.value.ngw].id
  destination_cidr_block = each.value.overlay_ip
  network_interface_id   = data.aws_instance.instance_info[each.value.instance_key].network_interface_id
}
