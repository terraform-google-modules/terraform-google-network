/*
  Description: This will create an Instances and Loadbalancers for a single AWS QTM Deployment within PCE.
  Layer: Options
  Notes:
*/

variable "qtm_vm_values" {
  description = <<-EOT
    Values for QTM virtual machines.
    (Set of 3. qtm_database, qtm_application, qtm_webdispatcher)
    Optional ami values will default to either
    the image_database or image_application variables
  EOT
  type = object({
    qtm_database = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
    qtm_application = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
    qtm_webdispatcher = object({
      instance_type                 = string
      meta_key_name                 = string
      ami_name                      = optional(string, null)
      ami_owner                     = optional(string, null)
      additional_tags               = optional(map(string), null)
      additional_security_group_ids = optional(list(string), [])
    })
  })
}

variable "qtm_certificate_arn" {
  description = "The ARN of the SSL Certificate to attach.  This is assumed to have already been imported into the ACM."
  type        = string
}

locals {
  qtm_vpc_info = local.layer_00_outputs.infrastructure.vpc_customer
  # Select the Subnet you want the Virtual Machines to be deployed in
  qtm_subnet_info = local.layer_00_outputs.infrastructure.subnet_EXAMPLE_production_1a
  qtm_vm_values   = var.qtm_vm_values
  qtm_ec2_key     = local.layer_02_outputs.key_pair_name

  # Select the DB Virtual Machines that QTM should access.
  qtm_egress_cidrs = {
    "___EXAMPLE___" = "${local.layer_02_outputs.instance_list["___EXAMPLE___"].private_ip}/32"
  }

  qtm_iam_instance_profile = local.layer_01_outputs.iam_role_customer_default.id

  qtm_alb_info = {
    # List of Subnets to attach to the ALB
    subnet_mappings = [
      local.layer_00_outputs.infrastructure.subnet_EXAMPLE_production_1a.id,
      local.layer_00_outputs.infrastructure.subnet_EXAMPLE_production_1b.id,
      local.layer_00_outputs.infrastructure.subnet_EXAMPLE_production_1c.id,
    ]
    # ARN of the SSL Certificate to attach.  This is assumed to have already been imported into the ACM.
    certificate_arn = var.qtm_certificate_arn
  }
}

module "qtm_example" {
  source     = "EXAMPLE_SOURCE/terraform/s4pce/modules/aws-qtm"
  build_user = var.build_user
  tags = merge(local.tags, {
    Name        = "${local.resource_prefix}-QTM"
    Description = title("${local.friendly_name} QTM")
  })
  context              = local.base_context
  vpc_info             = local.qtm_vpc_info
  subnet_info          = local.qtm_subnet_info
  vm_values            = local.qtm_vm_values
  ec2_key              = local.qtm_ec2_key
  egress_cidrs         = local.qtm_egress_cidrs
  iam_instance_profile = local.qtm_iam_instance_profile
  alb_info             = local.qtm_alb_info
  # Optional Values, see Module Docs for more information
  # adv_random_prefix = "test"
  # adv_image_database = {}
  # adv_image_application = {}
  # adv_alb_ingress_cidrs = { alb_ingress = "192.168.0.0/24"}
}

output "module" {
  value = module.qtm_example
}
