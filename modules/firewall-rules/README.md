# Google Cloud VPC Firewall

This module allows creation of a minimal VPC firewall, supporting basic configurable rules for IP range-based intra-VPC and administrator ingress,  tag-based SSH/HTTP/HTTPS ingress, and custom rule definitions.

The HTTP and HTTPS rules use the same network tags that are assigned to instances when the "Allow HTTP[S] traffic" checkbox is flagged in the Cloud Console. The SSH rule uses a generic `ssh` tag.

All IP source ranges are configurable through variables, and are set by default to `0.0.0.0/0` for tag-based rules. Allowed protocols and/or ports for the intra-VPC rule are also configurable through a variable.

Custom rules are set through a map where keys are rule names, and values use this custom type:

```hcl
map(object({
  description          = string
  direction            = string       # (INGRESS|EGRESS)
  action               = string       # (allow|deny)
  ranges               = list(string) # list of IP CIDR ranges
  sources              = list(string) # tags or SAs (ignored for EGRESS)
  targets              = list(string) # tags or SAs
  use_service_accounts = bool         # use tags or SAs in sources/targets
  rules = list(object({
    protocol = string
    ports    = list(string)
  }))
  extra_attributes = map(string)      # map, optional keys disabled or priority
}))
```

The resources created/managed by this module are:

- one optional ingress rule from internal CIDR ranges, only allowing ICMP by default
- one optional ingress rule from admin CIDR ranges, allowing all protocols on all ports
- one optional ingress rule for SSH on network tag `ssh` by default
- one optional ingress rule for HTTP on network tag `http-server` by default
- one optional ingress rule for HTTPS on network tag `https-server` by default
- one or more optional custom rules


## Usage

Basic usage of this module is as follows:

```hcl
module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id              = "my-project"
  network                 = "my-vpc"
  internal_ranges_enabled = true
  internal_ranges         = ["10.0.0.0/0"]
  internal_target_tags    = ["internal"]
  custom_rules = {
    ingress-sample = {
      description          = "Dummy sample ingress rule, tag-based."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["192.168.0.0"]
      sources              = ["spam-tag"]
      targets              = ["foo-tag", "egg-tag"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = []
        }
      ]
      extra_attributes = {}
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| network\_name | Name of the network this set of firewall rules applies to. | string | n/a | yes |
| project\_id | Project id of the project that holds the network. | string | n/a | yes |
| rules | List of custom rule definitions (refer to variables file for syntax). | object | `<list>` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
