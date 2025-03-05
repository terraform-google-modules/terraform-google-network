# aws-qtm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.49.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.2 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_list"></a> [instance\_list](#module\_instance\_list) | ../../../shared/modules/aws-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb.public_alb](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb) | resource |
| [aws_lb_listener.public_alb_listener](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.public_alb_target_group](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.public_alb_target_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.qtm_instance](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_security_group.qtm_lb](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.qtm_instance_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.qtm_lb_egress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.qtm_instance_ingress_intravpc](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.qtm_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/5.49.0/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_id.module](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [random_id.vm_name](https://registry.terraform.io/providers/hashicorp/random/3.6.3/docs/resources/id) | resource |
| [time_static.module](https://registry.terraform.io/providers/hashicorp/time/0.12.1/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_alb_ingress_cidrs"></a> [adv\_alb\_ingress\_cidrs](#input\_adv\_alb\_ingress\_cidrs) | IPv4 CIDRs to allow ingress to the ALB | `map(string)` | <pre>{<br/>  "default": "0.0.0.0/0"<br/>}</pre> | no |
| <a name="input_adv_image_application"></a> [adv\_image\_application](#input\_adv\_image\_application) | Default image for application VMs | <pre>object({<br/>    name  = string<br/>    owner = string<br/>  })</pre> | <pre>{<br/>  "name": "Golden-SCS-RHEL-8.6-SAPAPP-V*",<br/>  "owner": "156506675147"<br/>}</pre> | no |
| <a name="input_adv_image_database"></a> [adv\_image\_database](#input\_adv\_image\_database) | Default image for database VMs | <pre>object({<br/>    name  = string<br/>    owner = string<br/>  })</pre> | <pre>{<br/>  "name": "Golden-SCS-RHEL-8.6-HANA-V*",<br/>  "owner": "156506675147"<br/>}</pre> | no |
| <a name="input_adv_random_prefix"></a> [adv\_random\_prefix](#input\_adv\_random\_prefix) | Optional. Allows a prefix for generated random IDs. | `string` | `null` | no |
| <a name="input_alb_info"></a> [alb\_info](#input\_alb\_info) | Values for the Application Load Balancer<br/>subnet\_mappings - List of Subnet IDs to attach the ALB to. Minimum of 2 different zones.<br/>certificate\_arn - TLS certificate to attach to the Listener | <pre>object({<br/>    subnet_mappings   = list(string)<br/>    certificate_arn   = string<br/>    adv_listener_port = optional(number, 443)<br/>    adv_target_port   = optional(number, 44301)<br/>    adv_health_check = optional(list(map(string)), [{<br/>      enabled             = true<br/>      healthy_threshold   = 5<br/>      unhealthy_threshold = 2<br/>      timeout             = 5<br/>      interval            = 30<br/>      path                = "/sap/public/ping"<br/>      protocol            = "HTTPS"<br/>      port                = 44301<br/>    }])<br/>  })</pre> | n/a | yes |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | Employee ID for Tagging | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Null Context for VM creation.  Will be phased out eventually | `any` | n/a | yes |
| <a name="input_ec2_key"></a> [ec2\_key](#input\_ec2\_key) | EC2 key pair name assigned to the instances | `string` | n/a | yes |
| <a name="input_egress_cidrs"></a> [egress\_cidrs](#input\_egress\_cidrs) | Map of CIDRs the QTM Instances are allowed to connect to.<br/>This will typically be the IP Address of at least one backend system. | `map(string)` | `{}` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | ARN of the Instance Profile to attach to the QTM Instances | `string` | n/a | yes |
| <a name="input_subnet_info"></a> [subnet\_info](#input\_subnet\_info) | Subnet Info where resources will be created | <pre>object({<br/>    id = string<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources where applicable | `map(string)` | n/a | yes |
| <a name="input_vm_values"></a> [vm\_values](#input\_vm\_values) | Values for QTM virtual machines.<br/>(Set of 3. qtm\_database, qtm\_application, qtm\_webdispatcher)<br/>Optional ami values will default to either<br/>the image\_database or image\_application variables | <pre>object({<br/>    qtm_database = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>    qtm_application = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>    qtm_webdispatcher = object({<br/>      instance_type                 = string<br/>      meta_key_name                 = string<br/>      ami_name                      = optional(string, null)<br/>      ami_owner                     = optional(string, null)<br/>      additional_tags               = optional(map(string), null)<br/>      additional_security_group_ids = optional(list(string), [])<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_info"></a> [vpc\_info](#input\_vpc\_info) | VPC Info where resources will be created | <pre>object({<br/>    id         = string<br/>    cidr_block = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | QTM Public Application Load Balancer |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | QTM Module Metadata |
| <a name="output_security_groups"></a> [security\_groups](#output\_security\_groups) | AWS QTM Module Security Groups |
| <a name="output_virtual_machines"></a> [virtual\_machines](#output\_virtual\_machines) | QTM Virtual Machines |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
