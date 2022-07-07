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

You must ensure firewall rules are appropriately set up and target subnetwork has Private Google Access enabled.

Private Service Connect IP must fulfill requirements detailed [here](https://cloud.google.com/vpc/docs/configure-private-service-connect-apis#ip-address-requirements).


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment\_code | A short form of the folder level resources (environment) within the Google Cloud organization. | `string` | `"c"` | no |
| forwarding\_rule\_target | Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid. | `string` | n/a | yes |
| network\_self\_link | Network self link for Private Service Connect. | `string` | n/a | yes |
| private\_service\_connect\_ip | The internal IP to be used for the private service connect. | `string` | n/a | yes |
| project\_id | Project ID for Private Service Connect. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| global\_address\_id | An identifier for the global address created for the private service connect with format `projects/{{project}}/global/addresses/{{name}}` |
| private\_service\_connect\_ip | The private service connect ip |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->