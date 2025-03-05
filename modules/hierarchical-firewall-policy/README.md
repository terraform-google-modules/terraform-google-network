# Google Cloud Hierarchical Firewall Policy

This module allows creation of [hierarchical firewall policy](https://cloud.google.com/firewall/docs/firewall-policies) and [Rules](https://cloud.google.com/firewall/docs/firewall-policies-rule-details). It can also attach hierarchical firewall policy to multiple folders or an organization. It can create both [Cloud Firewall Essentials](https://cloud.google.com/firewall/docs/about-firewalls#firewall-essentials) and [Cloud Firewall Standard](https://cloud.google.com/firewall/docs/about-firewalls#firewall-standard) tier rules. You can create an empty firewall policy without any rules and without attaching it to any folder or organization. Hierarchical firewall policy limitations are available [here](https://cloud.google.com/firewall/docs/using-firewall-policies#limitations)

##  Module Format

Variable `rules` details are available [here](#firwall-policy-rules-format). High level format of this module is as follows:

```
module "hierarchical_firewall_policy" {
  source         = "terraform-google-modules/network/google//modules/hierarchical-firewall-policy"
  version        = "~> 9.0"

  parent_node    = "folders/123456789012"
  policy_name    = "test-policy"
  description    = "test firewall policy"
  target_folders = ["123456789012", "987654321098"]
  target_org     = "123456123456"

  rules = [
    {},
    {},
  ]
}
```

## Usage

There are examples included for [hierarchical firewall policy](../../examples/hierarchical-firewall-policy/) is in the [examples](../../examples/) folder. Basic usage of this module is as follows:

```hcl
module "firewal_policy" {
  source  = "terraform-google-modules/network/google//modules/hierarchical-firewall-policy"
  version = "~> 10.0"

  parent_node    = "folders/123456789012"
  policy_name    = "test-policy"
  description    = "test firewall policy"
  target_folders = ["123456789012", "987654321098"]
  target_org     = "123456123456"

  rules = [
    {
      priority       = "1"
      direction      = "INGRESS"
      action         = "allow"
      rule_name      = "ingress-1"
      description    = "test ingres rule 1"
      enable_logging = true
      match = {
        src_ip_ranges            = ["10.100.0.1/32"]
        src_fqdns                = ["example.com"]
        src_region_codes         = ["US"]
        src_threat_intelligences = ["iplist-public-clouds"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority    = "2"
      direction   = "INGRESS"
      action      = "deny"
      rule_name   = "ingress-2"
      disabled    = true
      description = "test ingres rule 2"
      match = {
        src_ip_ranges    = ["10.100.0.2/32"]
        src_fqdns        = ["example.org"]
        src_region_codes = ["BE"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority                = "3"
      direction               = "INGRESS"
      action                  = "allow"
      rule_name               = "ingress-3"
      disabled                = true
      description             = "test ingres rule 3"
      enable_logging          = true
      target_service_accounts = ["fw-test-svc-acct@${var.project_id}.iam.gserviceaccount.com"]
      match = {
        src_ip_ranges  = ["10.100.0.3/32"]
        dest_ip_ranges = ["10.100.0.103/32"]
        layer4_configs = [
          {
            ip_protocol = "tcp"
            ports       = ["80"]
          },
        ]
      }
    },
    {
      priority       = "101"
      direction      = "EGRESS"
      action         = "allow"
      rule_name      = "egress-101"
      description    = "test egress rule 101"
      enable_logging = true
      match = {
        src_ip_ranges             = ["10.100.0.2/32"]
        dest_fqdns                = ["example.com"]
        dest_region_codes         = ["US"]
        dest_threat_intelligences = ["iplist-public-clouds"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority    = "102"
      direction   = "EGRESS"
      action      = "deny"
      rule_name   = "egress-102"
      disabled    = true
      description = "test egress rule 102"
      match = {
        src_ip_ranges     = ["10.100.0.102/32"]
        dest_ip_ranges    = ["10.100.0.2/32"]
        dest_region_codes = ["AR"]
        layer4_configs = [
          {
            ip_protocol = "all"
          },
        ]
      }
    },
    {
      priority                = "103"
      direction               = "EGRESS"
      action                  = "allow"
      rule_name               = "egress-103"
      disabled                = true
      description             = "test ingres rule 103"
      enable_logging          = true
      target_service_accounts = ["fw-test-svc-acct@${var.project_id}.iam.gserviceaccount.com"]
      match = {
        dest_ip_ranges = ["10.100.0.103/32"]
        layer4_configs = [
          {
            ip_protocol = "tcp"
            ports       = ["80", "8080", "8081-8085"]
          },
        ]
      }
    },

  ]

}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | An optional description of this resource. Provide this property when you create the resource | `string` | `null` | no |
| parent\_node | The parent of the firewall policy. Parent should be in format organizations/<org-id> or folders/<folder\_id> | `string` | n/a | yes |
| policy\_name | User-provided name of the hierarchical firewall policy | `string` | n/a | yes |
| rules | List of Ingress/Egress rules | <pre>list(object({<br>    priority                = number<br>    direction               = string<br>    action                  = string<br>    rule_name               = optional(string)<br>    disabled                = optional(bool)<br>    description             = optional(string)<br>    enable_logging          = optional(bool)<br>    target_service_accounts = optional(list(string), [])<br>    target_resources        = optional(list(string), [])<br>    match = object({<br>      src_ip_ranges             = optional(list(string), [])<br>      src_fqdns                 = optional(list(string), [])<br>      src_region_codes          = optional(list(string), [])<br>      src_threat_intelligences  = optional(list(string), [])<br>      src_address_groups        = optional(list(string), [])<br>      dest_ip_ranges            = optional(list(string), [])<br>      dest_fqdns                = optional(list(string), [])<br>      dest_region_codes         = optional(list(string), [])<br>      dest_threat_intelligences = optional(list(string), [])<br>      dest_address_groups       = optional(list(string), [])<br>      layer4_configs = optional(list(object({<br>        ip_protocol = optional(string, "all")<br>        ports       = optional(list(string), [])<br>      })), [{}])<br>    })<br>  }))</pre> | `[]` | no |
| target\_folders | List of target folders IDs that the firewall policy will be attached to | `list(string)` | `[]` | no |
| target\_org | Target org id that the firewall policy will be attached to | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| fw\_policy | Firewall policy created |
| rules | Firewall policy rules created |
| target\_associations | folders/orgs associations created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Firwall Policy Rules Format

In a [firewall policy rule](https://cloud.google.com/firewall/docs/firewall-policies-rule-details), you specify a set of components that define what the rule does. Some of the values are optional and some have default value. See [Inputs](#Inputs). For sample code check [hierarchical firewall policy](../../examples/hierarchical-firewall-policy/) in [examples](../../examples/) folder.

- `priority`: An integer indicating the priority of a rule in the list. The `priority` must be a positive value between 0 and 2147483647 and It has to be unique for every rule.
- `target_resources`: A list of network resource URLs to which this rule applies. This field allows you to control which network's VMs get this rule. If this field is left blank, all VMs within the organization will receive the rule
- `target_service_accounts`: A list of network resource URLs to which this rule applies. This field allows you to control which network's VMs get this rule. If this field is left blank, all VMs within the organization will receive the rule
- `dest_fqdns`, `dest_region_codes`, `dest_threat_intelligences` and `dest_address_groups` values are not needed and ignored by the this for `INGRESS` policies.
- `src_fqdns`, `src_region_codes`, `src_threat_intelligences` and `src_address_groups` values are not needed and ignored by this module for `EGRESS` policies.
- `layer4_configs` is a list of maps.
  - `ip_protocol`: IP protocol to which this rule applies. The protocol type is required when creating a firewall rule. This value can either be one of the following well known protocol strings (`tcp`, `udp`, `icmp`, `esp`, `ah`, `ipip`, `sctp`), or the IP protocol number.
  - `ports`: An optional list of ports to which this rule applies. Field is only applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not specified, this rule applies to connections through any port.

### Format

```
  {
    priority                = 1
    direction               = "INGRESS"
    action                  = allow
    rule_name               = "my-test-policy"
    disabled                = false
    description             = "My test firewall policy"
    enable_logging          = true
    target_service_accounts = []
    target_resources        = []

    match = {
      src_ip_ranges             = []
      src_fqdns                 = []
      src_region_codes          = []
      src_address_groups        = []
      src_threat_intelligences  = []
      dest_ip_ranges            = []
      dest_fqdns                = []
      dest_region_codes         = []
      dest_threat_intelligences = []
      dest_address_groups       = []
      layer4_configs = [
        {
          ip_protocol = "tcp"
          ports       = ["80", "8080", "8081-8085"]
        },
      ]
    }
  }
```

## Requirements
### Installed Software
- [Terraform](https://www.terraform.io/downloads.html) >= 1.3
- [Terraform Provider for GCP](https://github.com/terraform-providers/terraform-provider-google) >= 4.64
- [Terraform Provider for GCP Beta](https://github.com/terraform-providers/terraform-provider-google-beta) >= 4.64

### Configure a Service Account
In order to execute this module you must have a Service Account with the following roles:

- roles/compute.orgFirewallPolicyAdmin at organization level
- compute.orgSecurityResourceAdmin on the folder to which the firewall policy will be attached
- compute.orgFirewallPolicyUser on the folder to which the firewall policy will be attached

### Enable API's
In order to operate with the Service Account you must activate the following API on the project where the Service Account was created:

- compute.googleapis.com
- networksecurity.googleapis.com
