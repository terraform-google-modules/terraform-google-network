/*
  Description: This will create an AWS Directory Service with additional options.
  Layer: Options
  Notes: Add this to your layer-options compatible root module to create an AWS Directory Service.
*/

variable "directory_service_create_options" {
  description = "Create options for the directory service"
  type = object({
    cloudwatch_log_group             = optional(bool, true)
    workspace_fullaccess_policy      = optional(bool, false)
    constrained_endpoint             = optional(bool, false)
    constrained_endpoint_dns_records = optional(bool, false)
    outbound_resolver                = optional(bool, false)
  })
}
variable "directory_service_config" {
  description = "Configuration for the directory service"
  type = object({
    netbios        = string
    admin_password = string
    fqdn           = string
  })
}
variable "directory_service_subnet_config" {
  description = "Recommended. Pass in two CIDR Ranges for subnet creation in different AZs. If not defined, will use pre-existing subnets. (Not Recommended)"
  type = map(object({
    cidr_block = string
    az         = string
  }))
  default = {}
}

locals {
  constrained_endpoint = {
    instance_profile = local.layer_01_outputs.iam_role_default.instance_profile_name
    vm_size          = "t3a.small"
    key_name         = local.layer_02_outputs.key_pair_main01.key_name
    subnet_id        = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
    security_group_ids = [
      local.layer_00_outputs.security_group_main01_vpc.id,
      local.layer_00_outputs.security_group_main01_all_egress.id,
    ]
  }
  constrained_endpoint_route53 = {
    zone_id = local.layer_00_outputs.route53_zone_main01.id
    cname   = "constrained"
  }
  outbound_resolver = {
    security_group_ids = [local.layer_00_outputs.security_group_main01_all_egress.id]
    name               = "${local.resource_prefix}-dns-outbound-forwarder"
  }

  create_subnets = var.directory_service_subnet_config == {} ? null : var.directory_service_subnet_config
  import_subnet_ids = var.directory_service_subnet_config == {} ? [
    local.layer_00_outputs.subnet_main01_infrastructure_1a.id,
    local.layer_00_outputs.subnet_main01_infrastructure_1b.id,
  ] : null
}


module "directory_service" {
  source                                  = "EXAMPLE_SOURCE/terraform/s4pce/modules/directory-service"
  create_cloudwatch_log_group             = var.directory_service_create_options.cloudwatch_log_group
  create_workspace_fullaccess_policy      = var.directory_service_create_options.workspace_fullaccess_policy
  create_constrained_endpoint             = var.directory_service_create_options.constrained_endpoint
  create_constrained_endpoint_dns_records = var.directory_service_create_options.constrained_endpoint_dns_records
  create_outbound_resolver                = var.directory_service_create_options.outbound_resolver


  directory_service        = var.directory_service_config
  directory_service_vpc_id = local.layer_00_outputs.vpc_main01.id
  directory_service_subnets = {
    create_subnets    = local.create_subnets
    import_subnet_ids = local.import_subnet_ids
  }

  constrained_endpoint         = local.constrained_endpoint
  constrained_endpoint_route53 = local.constrained_endpoint_route53
  outbound_resolver            = local.outbound_resolver

  tags = merge(local.tags, {
    Name        = "${local.resource_prefix}-DirectoryService"
    Description = title("${local.friendly_name} Directory Service")
  })
}
output "directory_service" {
  value = module.directory_service
}
