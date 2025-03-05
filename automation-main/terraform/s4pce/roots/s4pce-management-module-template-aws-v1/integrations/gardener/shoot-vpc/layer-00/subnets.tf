/*
  Description: Handles Subnet creation
  Comments:
*/

##### Private Link SFTPGo Subnets
resource "aws_subnet" "secondary_subnets" {
  for_each                = var.vpc_secondary_subnets
  vpc_id                  = aws_vpc.shoot.id
  availability_zone       = "${var.aws_region}${each.value.zone}"
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = "false"
  depends_on              = [aws_vpc_ipv4_cidr_block_association.shoot_secondary_cidr]
  tags = {
    Name = "${local.layer_resource_prefix}-${each.key}"
  }
}

resource "aws_db_subnet_group" "rds_subnets" {
  name       = "${local.layer_resource_prefix}-rds-subnet-group"
  subnet_ids = [for key, value in var.vpc_secondary_subnets : aws_subnet.secondary_subnets[key].id if value.for_rds]
  tags = {
    Name = "${local.layer_resource_prefix}-rds-subnet-group"
  }
}

##### Outputs
output "secondary_subnets" { value = {
  for key, value in aws_subnet.secondary_subnets : key => {
    name                 = key
    id                   = value.id
    arn                  = value.arn
    availability_zone    = value.availability_zone
    availability_zone_id = value.availability_zone_id
    cidr_block           = value.cidr_block
  }
} }
output "subnet_group_rds_sftpgo" { value = {
  id         = aws_db_subnet_group.rds_subnets.id
  arn        = aws_db_subnet_group.rds_subnets.arn
  name       = aws_db_subnet_group.rds_subnets.name
  subnet_ids = aws_db_subnet_group.rds_subnets.subnet_ids
} }
