/*
  Description: Creates the Customer VPC subnets; Creates basic subnets.  Subnets in other availabilty zones are commented out.
  Comments: N/A
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
}

output "subnets" { value = {
  for key, value in aws_subnet.customer_subnets : key => {
    name = value.tags.Name
    id   = value.id
  }
} }
