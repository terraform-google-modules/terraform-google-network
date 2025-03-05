
##### Endpoint Service Creation
resource "aws_vpc_endpoint_service" "networkloadbalancer" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.networkloadbalancer.arn]
  tags = merge(module.base_layer_context.tags, {
    Name        = var.nlb_name
    Description = title(replace(var.nlb_name, "-", " "))
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

##### Endpoint Service Allow Principal
resource "aws_vpc_endpoint_service_allowed_principal" "allow_principal" {
  for_each                = toset(var.principal_arns)
  vpc_endpoint_service_id = aws_vpc_endpoint_service.networkloadbalancer.id
  principal_arn           = each.value
}

resource "time_sleep" "networkloadbalancer" {
  create_duration = "30s"

  triggers = {
    service_name = aws_vpc_endpoint_service.networkloadbalancer.service_name
  }
}

##### Endpoint Creation
resource "aws_vpc_endpoint" "networkloadbalancer" {
  vpc_id              = var.endpoint_edge_vpc_id
  service_name        = time_sleep.networkloadbalancer.triggers.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.endpoint_security_group_list
  subnet_ids          = var.endpoint_subnet_list
  private_dns_enabled = false
  tags = merge(module.base_layer_context.tags, {
    Name        = var.nlb_name
    Description = title(replace(var.nlb_name, "-", " "))
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
