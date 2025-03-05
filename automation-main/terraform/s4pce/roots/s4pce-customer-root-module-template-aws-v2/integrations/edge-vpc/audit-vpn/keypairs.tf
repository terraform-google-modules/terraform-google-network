/*
  Description: Handles AWS SSH key pairs
  Comments: N/A
*/

module "context_key_pair_main01" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  flags       = { override_name = true }
  name        = "s4-auditor-${local.base_context.customer}"
  description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Key Pair"
}

resource "aws_key_pair" "main01" {
  key_name   = module.context_key_pair_main01.name
  public_key = var.ssh_auditor_key
  tags       = module.context_key_pair_main01.tags
}
