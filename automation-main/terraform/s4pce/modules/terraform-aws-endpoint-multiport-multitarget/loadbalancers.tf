/*
  Description: Creates Loadbalancer for Endpoint Service
  Comments:
*/

##### Get subnet metadata to discover VPC
data "aws_subnet" "main01" {
  for_each = toset(var.nlb_subnet_list)

  id = each.value
}


###### Create Network Load Balancer
resource "aws_lb" "main01" {
  name                             = var.nlb_name
  internal                         = true
  load_balancer_type               = "network"
  subnets                          = var.nlb_subnet_list
  enable_deletion_protection       = var.nlb_deletion_protection
  enable_cross_zone_load_balancing = var.nlb_enable_cross_zone_load_balancing
  tags = merge(module.base_layer_context.tags, {
    Name        = var.nlb_name
    Description = title(replace(var.nlb_name, "-", " "))
  })
}

##### Create Load Balancer Target Group
resource "aws_lb_target_group" "main01" {
  for_each    = toset(var.nlb_port_list)
  name        = "${var.nlb_name}-${each.value}"
  port        = each.value
  protocol    = "TCP"
  target_type = var.nlb_target_ip ? "ip" : "instance"
  vpc_id      = values(data.aws_subnet.main01)[0].vpc_id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${var.nlb_name}-${each.value}"
    Description = title(replace("${var.nlb_name} Port ${each.value}", "-", " "))
  })

  health_check {
    port     = var.nlb_health_check_port
    protocol = "TCP"
  }
}

##### Create Load Balancer Target Registration
locals {
  registration_sets = {
    for pair in setproduct(var.nlb_port_list, var.nlb_target_id) : "${pair[0]}__${pair[1]}" => {
      port      = pair[0]
      target_id = pair[1]
  } }
}

resource "aws_lb_target_group_attachment" "main01" {
  for_each          = local.registration_sets
  target_group_arn  = aws_lb_target_group.main01[each.value.port].arn
  target_id         = each.value.target_id
  port              = each.value.port
  availability_zone = var.nlb_target_az_all ? "all" : null
}

##### Customer Load Balancer Listener
resource "aws_lb_listener" "main01" {
  for_each          = toset(var.nlb_port_list)
  load_balancer_arn = aws_lb.main01.arn
  port              = each.value
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main01[each.value].arn
  }
  depends_on = [aws_lb_target_group_attachment.main01]
}
