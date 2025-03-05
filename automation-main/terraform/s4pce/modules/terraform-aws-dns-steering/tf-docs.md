# terraform-aws-dns-steering

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.75.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.2 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.75.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.5.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_module_context"></a> [module\_context](#module\_module\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.zone-cut](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.customerzone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [local_file.changelog](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_customer_id"></a> [customer\_id](#input\_customer\_id) | The internal customer ID string to setup DNS steering for. | `string` | n/a | yes |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | The records to be created under the customer zone, such that the key is the zone record (FOO for FOO.customer.toplevel) and the value is the target of the CNAME. | `map(string)` | n/a | yes |
| <a name="input_toplevelzone_fqdn"></a> [toplevelzone\_fqdn](#input\_toplevelzone\_fqdn) | The top-level DNS zone under which all customers' DNS steering zone are to housed. | `string` | n/a | yes |
| <a name="input_toplevelzone_id"></a> [toplevelzone\_id](#input\_toplevelzone\_id) | The top-level DNS zone under which all customers' DNS steering zone are to housed. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (optional) when using a private zone, you must provide a VPC ID. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_records"></a> [records](#output\_records) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
