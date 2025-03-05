# directory-service

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~>2.5.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~>0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.constrained_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_directory_service_directory.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_directory) | resource |
| [aws_directory_service_log_subscription.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/directory_service_log_subscription) | resource |
| [aws_iam_policy.workspace_fullaccess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_instance.constrained_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route53_record.constrained_endpoint_a_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.constrained_endpoint_cname](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_resolver_endpoint.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_rule.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_ssm_association.domainjoin_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_association) | resource |
| [aws_ssm_document.ssm_domain_join_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document) | resource |
| [aws_subnet.main01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [random_id.constrained_endpoint](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.workspace_fullaccess_policy](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_ami.constrained_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_aws_partition"></a> [adv\_aws\_partition](#input\_adv\_aws\_partition) | AWS Partition where resources will be created | `string` | `null` | no |
| <a name="input_adv_aws_region"></a> [adv\_aws\_region](#input\_adv\_aws\_region) | AWS Region where resources will be created | `string` | `null` | no |
| <a name="input_adv_constrained_image_search_owner_id"></a> [adv\_constrained\_image\_search\_owner\_id](#input\_adv\_constrained\_image\_search\_owner\_id) | The owner ID of the image to search for. | `string` | `"amazon"` | no |
| <a name="input_adv_constrained_image_search_type"></a> [adv\_constrained\_image\_search\_type](#input\_adv\_constrained\_image\_search\_type) | The type of image to search for. | `string` | `"name"` | no |
| <a name="input_adv_constrained_image_search_value"></a> [adv\_constrained\_image\_search\_value](#input\_adv\_constrained\_image\_search\_value) | The value used by image search. Should be either AMI ID or Name. | `string` | `"Windows_Server-2019-English-STIG-Core-*"` | no |
| <a name="input_adv_directory_service_description"></a> [adv\_directory\_service\_description](#input\_adv\_directory\_service\_description) | WARNING: NOT A TAG. This requires a destroy to change. String written to the directory service resource description | `string` | `null` | no |
| <a name="input_adv_directory_service_edition"></a> [adv\_directory\_service\_edition](#input\_adv\_directory\_service\_edition) | Either 'Standard' or 'Enterprise' for AWS Microsoft AD | `string` | `"Standard"` | no |
| <a name="input_adv_ds_cloudwatch_log_group_class"></a> [adv\_ds\_cloudwatch\_log\_group\_class](#input\_adv\_ds\_cloudwatch\_log\_group\_class) | (Forces Destroy on Change) Cloudwatch Log Group Class | `string` | `"STANDARD"` | no |
| <a name="input_adv_ds_cloudwatch_log_group_name"></a> [adv\_ds\_cloudwatch\_log\_group\_name](#input\_adv\_ds\_cloudwatch\_log\_group\_name) | (Forces Destroy on Change) Name of the Cloudwatch Log Group. Supercedes Prefix | `string` | `""` | no |
| <a name="input_adv_ds_cloudwatch_log_group_name_prefix"></a> [adv\_ds\_cloudwatch\_log\_group\_name\_prefix](#input\_adv\_ds\_cloudwatch\_log\_group\_name\_prefix) | (Forces Destroy on Change) Prefix of the Cloudwatch Log Group. Superceded by Name | `string` | `"/aws/directoryservice/"` | no |
| <a name="input_adv_ds_cloudwatch_log_group_retention"></a> [adv\_ds\_cloudwatch\_log\_group\_retention](#input\_adv\_ds\_cloudwatch\_log\_group\_retention) | (Forces Destroy on Change) Cloudwatch Log Group Class | `number` | `14` | no |
| <a name="input_constrained_endpoint"></a> [constrained\_endpoint](#input\_constrained\_endpoint) | (Optional) Create a Windows Constrained Endpoint with this configuration | <pre>object({<br/>    instance_profile   = string<br/>    vm_size            = optional(string, "t3a.small")<br/>    key_name           = string<br/>    subnet_id          = string<br/>    security_group_ids = optional(list(string), [])<br/>  })</pre> | <pre>{<br/>  "instance_profile": "",<br/>  "key_name": "",<br/>  "subnet_id": ""<br/>}</pre> | no |
| <a name="input_constrained_endpoint_route53"></a> [constrained\_endpoint\_route53](#input\_constrained\_endpoint\_route53) | (Optional) Create a Route53 entries with these values | <pre>object({<br/>    zone_id = string<br/>    cname   = string<br/>  })</pre> | <pre>{<br/>  "cname": "constrained",<br/>  "zone_id": ""<br/>}</pre> | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Create Cloudwatch Log Group for Directory Service | `bool` | `true` | no |
| <a name="input_create_constrained_endpoint"></a> [create\_constrained\_endpoint](#input\_create\_constrained\_endpoint) | Create a Windows Constrained Endpoint | `bool` | `false` | no |
| <a name="input_create_constrained_endpoint_dns_records"></a> [create\_constrained\_endpoint\_dns\_records](#input\_create\_constrained\_endpoint\_dns\_records) | Create Route53 entries for the Constrained Endpoint | `bool` | `false` | no |
| <a name="input_create_outbound_resolver"></a> [create\_outbound\_resolver](#input\_create\_outbound\_resolver) | Create Route53 Outbound Resolver Endpoints | `bool` | `false` | no |
| <a name="input_create_workspace_fullaccess_policy"></a> [create\_workspace\_fullaccess\_policy](#input\_create\_workspace\_fullaccess\_policy) | Create IAM Policy allowing all resources access to Directory Service and AWS Workspaces | `bool` | `false` | no |
| <a name="input_directory_service"></a> [directory\_service](#input\_directory\_service) | Create a Directory Service with these values | <pre>object({<br/>    netbios        = string<br/>    admin_password = string<br/>    fqdn           = string<br/>  })</pre> | n/a | yes |
| <a name="input_directory_service_subnets"></a> [directory\_service\_subnets](#input\_directory\_service\_subnets) | Mutually Exclusive. Either pass in Subnet IDs in two different AZs or pass in Subnet CIDRs to create in two different AZs. | <pre>object({<br/>    import_subnet_ids = optional(list(string), [])<br/>    create_subnets = optional(map(object({<br/>      cidr_block = string<br/>      az         = string<br/>    })), {})<br/>  })</pre> | n/a | yes |
| <a name="input_directory_service_vpc_id"></a> [directory\_service\_vpc\_id](#input\_directory\_service\_vpc\_id) | VPC ID where the directory service will be created | `string` | n/a | yes |
| <a name="input_outbound_resolver"></a> [outbound\_resolver](#input\_outbound\_resolver) | (Optional) Route53 Outbound Resolver Endpoints Configuration. | <pre>object({<br/>    security_group_ids = list(string)<br/>    name               = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Base Tags to apply to all resources | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#output\_cloudwatch\_log\_group) | n/a |
| <a name="output_constrained_endpoint"></a> [constrained\_endpoint](#output\_constrained\_endpoint) | n/a |
| <a name="output_directory_service"></a> [directory\_service](#output\_directory\_service) | n/a |
| <a name="output_outbound_resolver"></a> [outbound\_resolver](#output\_outbound\_resolver) | n/a |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | n/a |
| <a name="output_workspace_fullaccess_policy"></a> [workspace\_fullaccess\_policy](#output\_workspace\_fullaccess\_policy) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
