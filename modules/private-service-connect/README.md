# Private Service Connect

This module enables the usage of [Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect) for a specific subnetwork.

The resources created/managed by this module are:

- Private DNS zone to configure `private.googleapis.com.`
- Private DNS zone to configure `gcr.io.`
- Private DNS zone to configure `pdk.dev.`
- Global Address resource to configure `Private Service Connect` endpoint
- Global Forwarding Rule resource to forward traffic to respective HTTP(S) load balancing

## Usage

Basic usage of this module is as follows:

```hcl
module "private_service_connect" {
  source                     = "terraform-google-modules/network/google//modules/private-service-connect"

  project_id                 = "<PROJECT_ID>"
  network_self_link          = "<NETWORK_SELF_LINK>"
  private_service_connect_ip = "10.3.0.5"
  forwarding_rule_target     = "all-apis"
}
```

Private Service Connect IP must fulfill requirements detailed [here](https://cloud.google.com/vpc/docs/configure-private-service-connect-apis#ip-address-requirements).

Target subnetwork must have Private Google Access enabled.

**Note:**  All egress traffic is allowed from VPC internal networks by default.

If you have a firewall rule blocking egress traffic, you will need to configure a [new egress rule](https://cloud.google.com/vpc/docs/using-firewalls#creating_firewall_rules) with following attributes:

- Direction: Egress
- Priority: Higher than blocking egress rule
- Target tags: <FIREWALL_RULE_TAG>
- Destination filters:
   - IP ranges: <PRIVATE_SERVICE_CONNECT_IP>
   - Protocols and ports: tcp:443

## Requirements

- Cloud DNS API must be enabled.
- Service Account running Terraform must have `dns.managedZones.*` permissions. You can add them by assigning `DNS Admin` default role to the Service Account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_code | Code to identify DNS resources in the form of `{dns_code}-{dns_type}` | `string` | `"dz"` | no |
| forwarding\_rule\_name | Forwarding rule resource name. The forwarding rule name for PSC Google APIs must be an 1-20 characters string with lowercase letters and numbers and must start with a letter. Defaults to `globalrule` | `string` | `"globalrule"` | no |
| forwarding\_rule\_target | Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid. | `string` | n/a | yes |
| network\_self\_link | Network self link for Private Service Connect. | `string` | n/a | yes |
| private\_service\_connect\_ip | The internal IP to be used for the private service connect. | `string` | n/a | yes |
| private\_service\_connect\_name | Private Service Connect endpoint name. Defaults to `global-psconnect-ip` | `string` | `"global-psconnect-ip"` | no |
| project\_id | Project ID for Private Service Connect. | `string` | n/a | yes |
| psc\_global\_access | This is used in PSC consumer ForwardingRule to control whether the PSC endpoint can be accessed from another region. Defaults to `false` | `bool` | `false` | no |
| service\_directory\_namespace | Service Directory namespace to register the forwarding rule under. | `string` | `null` | no |
| service\_directory\_region | Service Directory region to register this global forwarding rule under. Defaults to `us-central1` if not defined. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_zone\_gcr\_name | Name for Managed DNS zone for GCR |
| dns\_zone\_googleapis\_name | Name for Managed DNS zone for GoogleAPIs |
| dns\_zone\_pkg\_dev\_name | Name for Managed DNS zone for PKG\_DEV |
| forwarding\_rule\_name | Forwarding rule resource name. |
| forwarding\_rule\_target | Target resource to receive the matched traffic. Only `all-apis` and `vpc-sc` are valid. |
| global\_address\_id | An identifier for the global address created for the private service connect with format `projects/{{project}}/global/addresses/{{name}}` |
| private\_service\_connect\_ip | Private service connect ip |
| private\_service\_connect\_name | Private service connect name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
