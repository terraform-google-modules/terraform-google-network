# Google Cloud VPC Firewall Policy

This module allows creation of `Global/Regional` Network Firewall Policy and Rules. It can also attach network firewall policy to multiple VPCs. If a value is provided for variable `policy_region`, module will create `Global` network firewall policy otherwise a `Regional` network firewall policy will be created.

## Usage

Basic usage of this module is as follows:

```hcl
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/network-firewall-policy"
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
            port        = 80
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
            ports       = [80]
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
| rules | List of ingress/egress rules | <pre>list(object({<br>    priority                = number<br>    direction               = string<br>    action                  = string<br>    rule_name               = optional(string)<br>    disabled                = optional(bool)<br>    description             = optional(string)<br>    enable_logging          = optional(bool)<br>    target_secure_tags      = optional(list(string))<br>    target_service_accounts = optional(list(string), [])<br>    match = object({<br>      src_ip_ranges             = optional(list(string), [])<br>      src_fqdns                 = optional(list(string), [])<br>      src_region_codes          = optional(list(string), [])<br>      src_secure_tags           = optional(list(string), [])<br>      src_address_groups        = optional(list(string), [])<br>      dest_ip_ranges            = optional(list(string), [])<br>      dest_fqdns                = optional(list(string), [])<br>      dest_region_codes         = optional(list(string), [])<br>      dest_threat_intelligences = optional(list(string), [])<br>      dest_address_groups       = optional(list(string), [])<br>      layer4_configs = optional(list(object({<br>        ip_protocol = optional(string, "all")<br>        ports       = optional(list(string), [])<br>      })), [{}])<br>    })<br>  }))</pre> | `[]` | no |
| target\_vpcs | List of target VPC IDs that the firewall policy will be attached to | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| fw\_policy | Firewall policy created |
| rules | Firewall policy rules created |
| vpc\_associations | VPC associations created |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
