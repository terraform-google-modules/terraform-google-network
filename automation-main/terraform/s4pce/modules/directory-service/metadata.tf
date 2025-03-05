/*
  Description: Metadata for the module
  Comments: Intentionally Blank
*/




data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {
  tags = merge(var.tags, {
    ModuleName = "directory_service"
  })
  aws_region    = var.adv_aws_region != null ? var.adv_aws_region : data.aws_region.current.name
  aws_partition = var.adv_aws_partition != null ? var.adv_aws_partition : data.aws_partition.current.partition
}
