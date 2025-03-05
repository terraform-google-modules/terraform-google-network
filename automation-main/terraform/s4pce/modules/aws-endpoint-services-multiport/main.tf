/*
  Description:
    Creates private link endpoints between VPCs to share TCP Applications.
    Create load balanacers and endpoint services in a service VPC.
    Creates endpoints that consume the service in a consumer VPC.
    The two VPC's do NOT need to be peered.
  Comments:
    This is an implementation of this AWS article: https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-securely-publish-internet-applications-at-scale-using-application-load-balancer-and-aws-privatelink/
*/

module "base_layer_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context
}
