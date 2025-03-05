/*
  Description: Handles AWS SSH key pairs
  Comments: N/A
*/

module "context_key_pair_main01" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  flags       = { override_name = true }
  name        = "${module.base_layer_context.security_boundary}-EXAMPLE_TESTING_UNIQUE_s4"
  description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Key Pair"
}

resource "aws_key_pair" "main01" {
  key_name   = module.context_key_pair_main01.name
  public_key = var.ssh_management_public_key
  tags       = module.context_key_pair_main01.tags
}
