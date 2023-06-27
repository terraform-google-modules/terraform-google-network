# Google Cloud VPC Firewall Rules

This module allows creation of custom VPC firewall rules.

## Usage

Variable `rules` details are available [here](#rules). Basic usage of this module is as follows:

```hcl
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
    name                    = "allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    destination_ranges      = ["10.0.0.0/8"]
    source_ranges           = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| egress\_rules | List of egress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| ingress\_rules | List of ingress rules. This will be ignored if variable 'rules' is non-empty | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    priority                = optional(number, null)<br>    destination_ranges      = optional(list(string), [])<br>    source_ranges           = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |
| network\_name | Name of the network this set of firewall rules applies to. | `string` | n/a | yes |
| project\_id | Project id of the project that holds the network. | `string` | n/a | yes |
| rules | This is DEPRICATED and available for backward compatiblity. Use ingress\_rules and egress\_rules variables. List of custom rule definitions | <pre>list(object({<br>    name                    = string<br>    description             = optional(string, null)<br>    direction               = optional(string, "INGRESS")<br>    priority                = optional(number, null)<br>    ranges                  = optional(list(string), [])<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br><br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })), [])<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rules | The created firewall rule resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## rules
In a [firewall rule](https://cloud.google.com/firewall/docs/firewalls), you specify a set of components that define what the rule does. Some of the values are optional and some have default value. For sample code check [firewall rules](https://github.com/terraform-google-modules/terraform-google-network/tree/master/examples/firewall-rules) in [examples](https://github.com/terraform-google-modules/terraform-google-network/tree/master/examples) folder. variable `rule.ranges` is kept for backward compatibility and should not be set at the same time as `rule.destination_ranges` OR `rule.source_ranges` otherwise module will generate an error message `ranges may not be set at the same time as destination_ranges OR source_ranges`.

- `ranges`: IP address range. This may not be set at the same time as `destination_ranges` OR `source_ranges`.
- `source_ranges`: (Optional) If source ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges. These ranges must be expressed in CIDR format. `source_ranges` may not be set at the same time as `ranges`
- `destination_ranges`: (Optional) If destination ranges are specified, the firewall will apply only to traffic that has destination IP address in these ranges. These ranges must be expressed in CIDR format. `destination_ranges` may not be set at the same time as `ranges`
- `name`: (Required) Name of the resource. Provided by the client when the resource is created. The name must be 1-63 characters long, the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash.
- `description`: (Optional) An optional description of this resource. Provide this property when you create the resource
- `direction`: (Optional) Direction of traffic to which this firewall applies; default is INGRESS
- `priority`: (Optional) Priority for this rule. This is an integer between 0 and 65535, both inclusive. When not specified, the value assumed is 1000
