# Google Cloud VPC Firewall Policy

This module allows creation of [Global](https://cloud.google.com/firewall/docs/network-firewall-policies) and [Regional](https://cloud.google.com/firewall/docs/regional-firewall-policies) Network Firewall Policy and [Rules](https://cloud.google.com/firewall/docs/firewall-policies-rule-details). It can also attach network firewall policy to multiple VPCs. Module will create a `Global` network firewall policy if a value is provided for variable `policy_region`, otherwise a `Regional` network firewall policy will be created. Module can create both [Cloud Firewall Essentials](https://cloud.google.com/firewall/docs/about-firewalls#firewall-essentials) and [Cloud Firewall Standard](https://cloud.google.com/firewall/docs/about-firewalls#firewall-standard) tier.

##  Module Format

```
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/network-firewall-policy"
  version      = "~> 8.0"
  project_id   = var.project_id
  policy_name  = "my-firewall-policy"
  description  = "Test firewall policy"
  target_vpcs  = [var.vpc1_id, var.vpc2_id]

  rules = [
    {},
    {},
  ]
}
```

## Usage

Basic usage of this module is as follows:

```hcl
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/network-firewall-policy"
  version      = "~> 8.0"
  project_id   = var.project_id
  policy_name  = "my-firewall-policy"
  description  = "Test firewall policy"
  target_vpcs  = [var.vpc1_id, var.vpc2_id]

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
        src_fqdns                = ["google.com"]
        src_region_codes         = ["US"]
        src_threat_intelligences = ["iplist-public-clouds"]
        src_secure_tags          = ["tagValues/${google_tags_tag_value.tag_value.name}"]
        src_address_groups       = [google_network_security_address_group.global_networksecurity_address_group.id]
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
        dest_fqdns                = ["google.com"]
        dest_region_codes         = ["US"]
        dest_threat_intelligences = ["iplist-public-clouds"]
        dest_address_groups       = [google_network_security_address_group.global_networksecurity_address_group.id]
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
      description             = "test ingres rule 102"
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
| policy\_name | User-provided name of the Network firewall policy | `string` | n/a | yes |
| policy\_region | Location of the firewall policy. Needed for regional firewall policies. Default is null (Global firewall policy) | `string` | `null` | no |
| project\_id | Project ID of the Network firewall policy | `string` | n/a | yes |
| rules | List of Ingress/Egress rules | <pre>list(object({<br>    priority                = number<br>    direction               = string<br>    action                  = string<br>    rule_name               = optional(string)<br>    disabled                = optional(bool)<br>    description             = optional(string)<br>    enable_logging          = optional(bool)<br>    target_secure_tags      = optional(list(string))<br>    target_service_accounts = optional(list(string), [])<br>    match = object({<br>      src_ip_ranges             = optional(list(string), [])<br>      src_fqdns                 = optional(list(string), [])<br>      src_region_codes          = optional(list(string), [])<br>      src_secure_tags           = optional(list(string), [])<br>      src_address_groups        = optional(list(string), [])<br>      dest_ip_ranges            = optional(list(string), [])<br>      dest_fqdns                = optional(list(string), [])<br>      dest_region_codes         = optional(list(string), [])<br>      dest_threat_intelligences = optional(list(string), [])<br>      dest_address_groups       = optional(list(string), [])<br>      layer4_configs = optional(list(object({<br>        ip_protocol = optional(string, "all")<br>        ports       = optional(list(string), [])<br>      })), [{}])<br>    })<br>  }))</pre> | `[]` | no |
| target\_vpcs | List of target VPC IDs that the firewall policy will be attached to | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| fw\_policy | Firewall policy created |
| rules | Firewall policy rules created |
| vpc\_associations | VPC associations created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Firwall Policy Rules Format

In a [firewall policy rule](https://cloud.google.com/firewall/docs/firewall-policies-rule-details), you specify a set of components that define what the rule does. Some of the values are optional and some have default value. See [Inputs](#Inputs).

- `dest_fqdns`, `dest_region_codes`, `dest_threat_intelligences` and `dest_address_groups` values are not needed and ignored by the module for `INGRESS` policies.
- `src_fqdns`, `src_region_codes`, `src_threat_intelligences` and `src_address_groups` values are not needed and ignored by the module for `EGRESS` policies.
- `target_secure_tags` may not be set at the same time as `target_service_accounts`. If `target_service_accounts` is provided module will generate an error message.
- `layer4_configs` is a list of maps.
  - `ip_protocol`: IP protocol to which this rule applies. The protocol type is required when creating a firewall rule. This value can either be one of the following well known protocol strings (`tcp`, `udp`, `icmp`, `esp`, `ah`, `ipip`, `sctp`), or the IP protocol number.
  - `ports`: An optional list of ports to which this rule applies. Field is only applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not specified, this rule applies to connections through any port.


```
  {
    priority                = 1
    direction               = "INGRESS"
    action                  = allow
    rule_name               = "my-test-policy"
    disabled                = false
    description             = "My test firewall policy"
    enable_logging          = true
    target_secure_tags      = ["tagValues/${google_tags_tag_value.tag_value.name}",]
    target_service_accounts = ["fw-test-svc-acct@$my-project-id.iam.gserviceaccount.com"]
    match = object({
      src_ip_ranges             = ["10.100.0.2"]
      src_fqdns                 = []
      src_region_codes          = []
      src_secure_tags           = []
      src_address_groups        = []
      dest_ip_ranges            = ["10.100.100.2"]
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
