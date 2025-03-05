/*
  Description: Terraform main file; Instances for S4PCE
  Comments:
*/

##### Instances
module "s4pce_customer_instances" {
  source  = "../../ste-automation/terraform/s4pce/modules/s4pce-customer-instances"
  context = module.base_layer_context.context

  # Network
  vpc_id  = local.layer_00_outputs.infrastructure.vpc_customer.id
  subnets = local.layer_00_outputs.infrastructure.subnets
  network = local.layer_00_outputs.infrastructure.network

  # Instance Variables
  image_database_name    = var.image_database_name
  image_application_name = var.image_application_name
  ssh_main01_public_key  = var.ssh_main01_public_key
  ssh_keypair_name       = try(var.ssh_keypair_name, null)
  ami_owner_default      = var.ami_owner_default
  rhel_patch_group       = local.management_layer_01_outputs.ssm_customer_rhel_general.patch_group
  windows_patch_group    = local.management_layer_01_outputs.ssm_customer_windows_general.patch_group
  ubuntu_patch_group     = local.management_layer_01_outputs.ssm_customer_ubuntu_general.patch_group
  instance_security_groups_list = [
    local.layer_00_outputs.infrastructure.security_group_vpc.id,
    local.layer_00_outputs.infrastructure.security_group_all_egress.id,
    local.layer_00_outputs.infrastructure.security_group_customer_access_management.id,
  ]
  instance_route53_zone_id = local.layer_00_outputs.infrastructure.route53_zone.id
  instance_iam_role        = local.layer_01_outputs.iam.iam_role_customer_default.id

  instance_list = var.instance_list

  ha_instances = var.ha_instances

  # SAP Router
  saprouter_ingress_cidr = var.saprouter_ingress_cidr

}

output "s4pce_customer_instances" { value = module.s4pce_customer_instances }
