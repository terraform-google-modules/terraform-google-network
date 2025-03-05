/*
  Description:
    Creates private link endpoints between VPCs to share TCP Applications.
    Create load balanacers and endpoint services in a service VPC.
    Creates endpoints that consume the service in a consumer VPC.
    The two VPC's do NOT need to be peered.
  Comments:
    This is an implementation of this AWS article: https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/
*/

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
  tags = {
    Generated-By = "terraform"
    Managed-By   = "terraform"
    BuildUser    = var.build_user
    Name         = var.nlb_name
  }
  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = false
  }

}

##### Create Load Balancer Target Group
resource "aws_lb_target_group" "networkloadbalancer" {
  name        = var.nlb_name
  port        = var.nlb_target_port
  protocol    = "TCP"
  target_type = var.nlb_target_ip ? "ip" : "instance"
  vpc_id      = data.aws_subnet.networkloadbalancer.vpc_id
  tags = {
    Name         = "${var.nlb_name}-target"
    Generated-By = "terraform"
    Managed-By   = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = false
  }
}

##### Create Load Balancer Target Registration
resource "aws_lb_target_group_attachment" "networkloadbalancer" {
  target_group_arn  = aws_lb_target_group.networkloadbalancer.arn
  target_id         = var.nlb_instance_id
  port              = var.nlb_target_port
  availability_zone = var.nlb_target_az_all ? "all" : null
}

##### Customer Load Balancer Listener
resource "aws_lb_listener" "networkloadbalancer" {
  load_balancer_arn = aws_lb.networkloadbalancer.arn
  port              = var.nlb_listener_port
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.networkloadbalancer.arn
  }
  depends_on = [aws_lb_target_group_attachment.networkloadbalancer]
}

##### Endpoint Service Creation
resource "aws_vpc_endpoint_service" "networkloadbalancer" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.networkloadbalancer.arn]
  tags = {
    Name         = var.nlb_name
    Generated-By = "terraform"
    Managed-By   = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = false
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
  tags = {
    Name         = var.nlb_name
    Generated-By = "terraform"
    Managed-By   = "terraform"
    BuildUser    = var.build_user
  }
  lifecycle {
    ignore_changes  = [tags]
    prevent_destroy = false
  }
}
