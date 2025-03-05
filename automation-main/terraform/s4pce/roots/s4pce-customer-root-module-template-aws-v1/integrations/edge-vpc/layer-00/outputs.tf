// /*
//   Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
//   Layer: 00
//   Comments: N/A
// */



##### Metadata variables

##### Endpoints
output "ha_endpoints" { value = module.ha_endpoints }
output "endpoint_list" { value = module.endpoint_list }
output "sftp_list" { value = module.sftp_endpoints }
output "nlb_endpoints" { value = local.nlb_endpoints_outputs }
output "zzz_Message" { value = "Endpoint File written to /tmp/endpoints-${module.base_layer_context.security_boundary}-${local.base_context.customer}.md" }
locals {
  endpoint_output = templatefile(
    "./output-endpoints.tpl",
    {
      endpoint_list = merge(module.endpoint_list, module.ha_endpoints)
      sftp_list     = module.sftp_endpoints
      nlb_list      = local.nlb_endpoints_outputs
    }
  )
}
resource "local_file" "file_content" {
  content  = local.endpoint_output
  filename = "/tmp/endpoints-${module.base_layer_context.security_boundary}-${local.base_context.customer}.md"
}

##### Gateways
output "vpn_gateway" { value = { id = aws_vpn_gateway.main01.id } }

##### Routes
output "route_table_main01_default" { value = {
  id   = aws_default_route_table.main01_default.id
  name = aws_default_route_table.main01_default.tags.Name
} }

###### Security Groups
output "security_group_main01_all_egress" { value = {
  id   = aws_security_group.main01_all_egress.id
  name = aws_security_group.main01_all_egress.tags.Name
} }
output "security_group_main01_ingress" { value = {
  id   = aws_security_group.main01_ingress.id
  name = aws_security_group.main01_ingress.tags.Name
} }

##### Subnets
output "subnet_main01_infrastructure_1a" { value = {
  name = aws_subnet.main01_infrastructure_1a.tags.Name
  id   = aws_subnet.main01_infrastructure_1a.id
} }

output "subnet_main01_infrastructure_1b" { value = {
  name = aws_subnet.main01_infrastructure_1b.tags.Name
  id   = aws_subnet.main01_infrastructure_1b.id
} }

output "subnet_main01_infrastructure_1c" { value = {
  name = aws_subnet.main01_infrastructure_1c.tags.Name
  id   = aws_subnet.main01_infrastructure_1c.id
} }

##### VPC
output "vpc_main01" { value = {
  name        = aws_vpc.main01.tags.Name
  id          = aws_vpc.main01.id
  cidr_block  = aws_vpc.main01.cidr_block
  description = aws_vpc.main01.tags.Description
} }
