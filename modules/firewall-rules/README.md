# Google Cloud VPC Firewall Rules

This module allows creation of custom VPC firewall rules.

## Usage

Basic usage of this module is as follows:

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
    ranges                  = ["0.0.0.0/0"]
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
| network\_name | Name of the network this set of firewall rules applies to. | `string` | n/a | yes |
| project\_id | Project id of the project that holds the network. | `string` | n/a | yes |
| rules | List of custom rule definitions (refer to variables file for syntax). | <pre>list(object({<br>    name                    = string<br>    description             = optional(string)<br>    direction               = optional(string)<br>    priority                = optional(number)<br>    ranges                  = optional(list(string))<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br>    allow = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })))<br>    deny = optional(list(object({<br>      protocol = string<br>      ports    = optional(list(string))<br>    })))<br>    log_config = optional(object({<br>      metadata = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rules | The created firewall rule resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
