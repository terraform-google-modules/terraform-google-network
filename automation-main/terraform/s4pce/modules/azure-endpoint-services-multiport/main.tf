/*
  Description:
    Create private link endpoints between VNets to share TCP Applications.
    Create load balancers and endpoint services in a service VNet.
    Create endpoints that consume the service in a customer VNet.
    The two VNets do NOT need to be peered.
*/

module "base_layer_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context
}
