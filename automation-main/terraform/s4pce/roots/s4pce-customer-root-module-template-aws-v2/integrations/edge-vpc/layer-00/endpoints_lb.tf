/*
  Description: Creates SFTP Service and Endpoint for a Customer using loadbalancer inputs.
  Comments:
    * Because this creates both Service and Endpoints, the loadbalancer should be unique to the customer.
*/


data "aws_lb" "networkloadbalancer" {
  for_each = toset(var.loadbalancer_names)
  name     = each.value
}

resource "random_id" "networkloadbalancer" {
  for_each = toset(var.loadbalancer_names)
  keepers = {
    loadbalancer_arn = data.aws_lb.networkloadbalancer[each.key].arn
  }
  # Adding ignore to follow best practice regarding keepers
  lifecycle {
    ignore_changes = [keepers["loadbalancer_arn"]]
  }
  byte_length = 4
  prefix      = "${module.base_layer_context.resource_prefix}-"
}

resource "aws_vpc_endpoint_service" "networkloadbalancer" {
  for_each                   = toset(var.loadbalancer_names)
  acceptance_required        = false
  network_load_balancer_arns = [data.aws_lb.networkloadbalancer[each.key].arn]
  tags = merge(module.base_layer_context.tags, {
    Name        = random_id.networkloadbalancer[each.key].hex
    Description = "Service for NLB ${each.key}"
  })
}

##### Endpoint Creation
resource "aws_vpc_endpoint" "networkloadbalancer" {
  for_each          = toset(var.loadbalancer_names)
  vpc_id            = aws_vpc.main01.id
  service_name      = aws_vpc_endpoint_service.networkloadbalancer[each.key].service_name
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.main01_all_egress.id,
    aws_security_group.main01_ingress.id
  ]
  subnet_ids = [
    aws_subnet.main01_infrastructure_1a.id,
    aws_subnet.main01_infrastructure_1b.id,
    aws_subnet.main01_infrastructure_1c.id,
  ]
  private_dns_enabled = false
  tags = merge(module.base_layer_context.tags, {
    Name        = random_id.networkloadbalancer[each.key].hex
    Description = "Endpoint for NLB ${each.key}"
  })
}

locals {
  nlb_endpoints_outputs = {
    for k, v in aws_vpc_endpoint.networkloadbalancer : k => v.dns_entry[0]
  }
}
