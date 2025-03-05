# terraform-aws-endpoint-multiport-multitarget

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.70.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.70.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_layer_context"></a> [base\_layer\_context](#module\_base\_layer\_context) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_vpc_endpoint.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_service.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service) | resource |
| [aws_vpc_endpoint_service_allowed_principal.allow_principal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service_allowed_principal) | resource |
| [time_sleep.main01](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_subnet.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_endpoint_create"></a> [endpoint\_create](#input\_endpoint\_create) | Create a VPC Endpoint | `bool` | `true` | no |
| <a name="input_endpoint_edge_vpc_id"></a> [endpoint\_edge\_vpc\_id](#input\_endpoint\_edge\_vpc\_id) | Edge VPC ID | `string` | `null` | no |
| <a name="input_endpoint_security_group_list"></a> [endpoint\_security\_group\_list](#input\_endpoint\_security\_group\_list) | Security groups applied to the endpoint. | `list(string)` | `[]` | no |
| <a name="input_endpoint_subnet_list"></a> [endpoint\_subnet\_list](#input\_endpoint\_subnet\_list) | Subnets to place the endpoints into. | `list(string)` | `[]` | no |
| <a name="input_nlb_deletion_protection"></a> [nlb\_deletion\_protection](#input\_nlb\_deletion\_protection) | Enables/Disables termination protection | `bool` | `false` | no |
| <a name="input_nlb_enable_cross_zone_load_balancing"></a> [nlb\_enable\_cross\_zone\_load\_balancing](#input\_nlb\_enable\_cross\_zone\_load\_balancing) | Enables cross zone load balancing on the load balancer | `bool` | `true` | no |
| <a name="input_nlb_health_check_port"></a> [nlb\_health\_check\_port](#input\_nlb\_health\_check\_port) | (Optional) Port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port. | `string` | `"traffic-port"` | no |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | Name of the Network Load Balancer | `any` | n/a | yes |
| <a name="input_nlb_port_list"></a> [nlb\_port\_list](#input\_nlb\_port\_list) | List of ports to listen and forward to | `any` | n/a | yes |
| <a name="input_nlb_subnet_list"></a> [nlb\_subnet\_list](#input\_nlb\_subnet\_list) | Subnets the load balancer will reside in. | `any` | n/a | yes |
| <a name="input_nlb_target_az_all"></a> [nlb\_target\_az\_all](#input\_nlb\_target\_az\_all) | Sets the AZ to `all`. Required if IP is outside the VPC | `bool` | `false` | no |
| <a name="input_nlb_target_id"></a> [nlb\_target\_id](#input\_nlb\_target\_id) | Instance or IP address to forward the Network Load Balancer to. | `any` | n/a | yes |
| <a name="input_nlb_target_ip"></a> [nlb\_target\_ip](#input\_nlb\_target\_ip) | Target IP address instead of instance type | `bool` | `false` | no |
| <a name="input_principal_arns"></a> [principal\_arns](#input\_principal\_arns) | ARNs of the principals to allow | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_endpoint_service"></a> [endpoint\_service](#output\_endpoint\_service) | n/a |
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
