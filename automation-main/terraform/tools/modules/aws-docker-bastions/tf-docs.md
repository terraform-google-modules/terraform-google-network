# aws-docker-bastions

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.49.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.49.0 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.docker_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [time_static.docker_bastion](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adv_iam_instance_profile"></a> [adv\_iam\_instance\_profile](#input\_adv\_iam\_instance\_profile) | (Optional) IAM Profile | `string` | `null` | no |
| <a name="input_adv_public_ip"></a> [adv\_public\_ip](#input\_adv\_public\_ip) | (Optional) Add a Public IP to the instance | `bool` | `false` | no |
| <a name="input_adv_vm_size"></a> [adv\_vm\_size](#input\_adv\_vm\_size) | (Optional) Virtual Machine Size | `string` | `"t3a.small"` | no |
| <a name="input_build_user"></a> [build\_user](#input\_build\_user) | User ID of Terraform Build User | `string` | n/a | yes |
| <a name="input_docker_bastion_list"></a> [docker\_bastion\_list](#input\_docker\_bastion\_list) | Name List of Docker Bastions | `list(string)` | `[]` | no |
| <a name="input_image_ubuntu"></a> [image\_ubuntu](#input\_image\_ubuntu) | Ubuntu AMI to use for Docker Bastion | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key Pair Name | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security Groups IDs | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_docker_bastions"></a> [docker\_bastions](#output\_docker\_bastions) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
