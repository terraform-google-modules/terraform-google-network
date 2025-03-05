/*
  Description: Creates the Customer VPC subnets; Creates basic subnets.
  Comments:
*/

resource "aws_subnet" "customer_subnets" {
  for_each                = local.subnet_all_map
  vpc_id                  = aws_vpc.customer.id
  availability_zone       = "${var.aws_region}${each.value.zone}"
  cidr_block              = each.value.subnet_cidr
  map_public_ip_on_launch = false
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-az1${each.value.zone}-${each.key}"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Az1${each.value.zone} ${each.key}")
  })

  depends_on = [aws_vpc_ipv4_cidr_block_association.main]
}
