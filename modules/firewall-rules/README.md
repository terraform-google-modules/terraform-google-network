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
    name = "allow-ssh-ingress"
    priority = null
    description = null
    direction = "INGRESS"
    ranges = ["0.0.0.0/0"]
    source = {
      tags = null
      service_accounts = null
    }
    target = {
      tags = null
      service_accounts = null
    }
    allow = [{
      protocol = "tcp"
      ports = ["22"]
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
|------|-------------|:----:|:-----:|:-----:|
| network\_name | Name of the network this set of firewall rules applies to. | string | n/a | yes |
| project\_id | Project id of the project that holds the network. | string | n/a | yes |
| rules | List of custom rule definitions (refer to variables file for syntax). | object | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rules | The created firewall rule resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
