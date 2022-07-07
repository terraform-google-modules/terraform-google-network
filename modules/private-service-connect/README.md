# Private Service Networks

This module enables the usage of [Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect) for a specific subnetwork.

the resources created/managed by this module are:

- one private DNS zone to configure `private.googleapis.com.`
- one private DNS zone to configure `gcr.io.`
- one private DNS zone to configure `pdk.dev.`
- one Global Address resource to configure `Private Service Connect` endpoint
- one Global Forwarding Rule resource to forward traffic to respective HTTP(S) load balancing

# Usage

Basic usage of this module is as follows:

```hcl
module "private_service_connect" {
  source                     = "terraform-google-modules/network/google//modules/private_service_connect"

  project_id                 = "project-1234"
  environment_code           = "env-code"
  network_self_link          = "<NETWORK SELF LINK>"
  private_service_connect_ip = "10.3.0.5"
  forwarding_rule_target     = "all-apis|vpc-sc"
}
```
# Notes
You must ensure firewall are appropriately set up and target subnetwork has Private Google Access enabled.

Private Service Connect IP must fulfill requirements detailed [here](https://cloud.google.com/vpc/docs/configure-private-service-connect-apis#ip-address-requirements).


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->