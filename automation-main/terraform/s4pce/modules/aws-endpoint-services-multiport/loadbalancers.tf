locals {
  nlb_target_id_list = var.nlb_target_id == "" ? var.nlb_target_ids : [var.nlb_target_id]
  nlb_target_list    = setproduct(local.nlb_target_id_list, var.nlb_port_list)
  nlb_target_map = {
    for key, value in local.nlb_target_list : key => {
      target_id = value[0]
      port      = value[1]
    }
  }
}

# TODO(mschenck) test with instance IDs, not just IPs for var.nlb_target_id

##### Get subnet metadata to discover VPC
data "aws_subnet" "networkloadbalancer" {
  id = var.nlb_subnet_list[0]
}


###### Create Network Load Balancer
resource "aws_lb" "networkloadbalancer" {
  name                             = var.nlb_name
  internal                         = true
  load_balancer_type               = "network"
  subnets                          = var.nlb_subnet_list
  enable_deletion_protection       = var.nlb_deletion_protection
  enable_cross_zone_load_balancing = true
  tags = merge(module.base_layer_context.tags, {
    Name        = var.nlb_name
    Description = title(replace(var.nlb_name, "-", " "))
  })
}

##### Create Load Balancer Target Group
resource "aws_lb_target_group" "networkloadbalancer" {
  for_each    = toset(var.nlb_port_list)
  name        = "${var.nlb_name}-${each.value}"
  port        = each.value
  protocol    = "TCP"
  target_type = var.nlb_target_ip ? "ip" : "instance"
  vpc_id      = data.aws_subnet.networkloadbalancer.vpc_id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${var.nlb_name}-${each.value}"
    Description = title(replace("${var.nlb_name} Port ${each.value}", "-", " "))
  })
}

##### Create Load Balancer Target Registration
resource "aws_lb_target_group_attachment" "networkloadbalancer" {
  for_each          = local.nlb_target_map
  target_group_arn  = aws_lb_target_group.networkloadbalancer[each.value.port].arn
  target_id         = each.value.target_id
  port              = each.value.port
  availability_zone = var.nlb_target_az_all ? "all" : null
}

##### Customer Load Balancer Listener
resource "aws_lb_listener" "networkloadbalancer" {
  for_each          = toset(var.nlb_port_list)
  load_balancer_arn = aws_lb.networkloadbalancer.arn
  port              = each.value
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.networkloadbalancer[each.value].arn
  }
  depends_on = [aws_lb_target_group_attachment.networkloadbalancer]
}
