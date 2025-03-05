# s4pce-customer-infrastructure-gcp

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.1.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_context_customer_ngw"></a> [context\_customer\_ngw](#module\_context\_customer\_ngw) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_customer_router"></a> [context\_customer\_router](#module\_context\_customer\_router) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_filestore_customer_usr_sap_trans"></a> [context\_filestore\_customer\_usr\_sap\_trans](#module\_context\_filestore\_customer\_usr\_sap\_trans) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_filestore_customer_usr_sap_trans_backup"></a> [context\_filestore\_customer\_usr\_sap\_trans\_backup](#module\_context\_filestore\_customer\_usr\_sap\_trans\_backup) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_gcp_customer_backup"></a> [context\_gcp\_customer\_backup](#module\_context\_gcp\_customer\_backup) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_gcp_firewall_customer_access_management"></a> [context\_gcp\_firewall\_customer\_access\_management](#module\_context\_gcp\_firewall\_customer\_access\_management) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_gcp_firewall_customer_all_egress"></a> [context\_gcp\_firewall\_customer\_all\_egress](#module\_context\_gcp\_firewall\_customer\_all\_egress) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_gcp_firewall_customer_ilb_health_check"></a> [context\_gcp\_firewall\_customer\_ilb\_health\_check](#module\_context\_gcp\_firewall\_customer\_ilb\_health\_check) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_gcp_firewall_customer_vpc"></a> [context\_gcp\_firewall\_customer\_vpc](#module\_context\_gcp\_firewall\_customer\_vpc) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_ip_customer_ngw"></a> [context\_ip\_customer\_ngw](#module\_context\_ip\_customer\_ngw) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_service_account"></a> [context\_service\_account](#module\_context\_service\_account) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_subnetworks_customer_development"></a> [context\_subnetworks\_customer\_development](#module\_context\_subnetworks\_customer\_development) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_subnetworks_customer_edge"></a> [context\_subnetworks\_customer\_edge](#module\_context\_subnetworks\_customer\_edge) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_subnetworks_customer_production"></a> [context\_subnetworks\_customer\_production](#module\_context\_subnetworks\_customer\_production) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_context_subnetworks_customer_quality_assurance"></a> [context\_subnetworks\_customer\_quality\_assurance](#module\_context\_subnetworks\_customer\_quality\_assurance) | ../../../shared/modules/terraform-null-context/modules/legacy | n/a |
| <a name="module_module_context"></a> [module\_context](#module\_module\_context) | ../terraform-null-context/modules/legacy | n/a |

## Resources

| Name | Type |
|------|------|
| [google_cloud_scheduler_job.fs_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_scheduler_job) | resource |
| [google_cloudfunctions_function.fs_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function) | resource |
| [google_cloudfunctions_function_iam_member.invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam_member) | resource |
| [google_compute_address.customer_ngw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.access_management](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.customer_all_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.customer_ilb_health_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.customer_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.customer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.customer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.customer_ngw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.customer_development](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.customer_edge](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.customer_production](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.customer_quality_assurance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_filestore_instance.customer_usr_sap_trans](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/filestore_instance) | resource |
| [google_project_iam_custom_role.serviceaccountrole](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.admin-account-iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket.customer_backups](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.gcpbackup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [local_file.changelog](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_function_fsbackup_source"></a> [cloud\_function\_fsbackup\_source](#input\_cloud\_function\_fsbackup\_source) | Path to fsbackup.zip cloud function code | `string` | n/a | yes |
| <a name="input_cloud_functions_bucket"></a> [cloud\_functions\_bucket](#input\_cloud\_functions\_bucket) | GCS bucket source for cloud functions | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | n/a | <pre>object({<br/>    account_id             = string<br/>    additional_tags        = map(string)<br/>    build_user             = string<br/>    business               = string<br/>    customer               = string<br/>    delimiter              = string<br/>    environment            = string<br/>    environment_salt       = string<br/>    generated_by           = string<br/>    include_customer_label = bool<br/>    label_order            = list(string)<br/>    managed_by             = string<br/>    module                 = string<br/>    module_version         = string<br/>    name_prefix            = string<br/>    organization           = string<br/>    owner                  = string<br/>    partition              = string<br/>    parent_module          = string<br/>    parent_module_version  = string<br/>    regex_replace_chars    = string<br/>    region                 = string<br/>    root_module            = string<br/>    security_boundary      = string<br/><br/>    custom_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    environment_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    module_values = object({<br/>      kv     = map(string)<br/>      locals = any<br/>      tags = list(object({<br/>        name     = string<br/>        value    = string<br/>        required = bool<br/>      }))<br/>    })<br/><br/>    resource_tags = list(<br/>      object({<br/>        name         = string<br/>        value        = string<br/>        required     = bool<br/>        pass_context = bool<br/>      })<br/>    )<br/><br/>  })</pre> | `null` | no |
| <a name="input_delete_after_days"></a> [delete\_after\_days](#input\_delete\_after\_days) | Delete after days since modification greater than | `number` | `180` | no |
| <a name="input_filestore_size"></a> [filestore\_size](#input\_filestore\_size) | Size of filestore to be provisioned | `string` | `1024` | no |
| <a name="input_gcn_cidr_block"></a> [gcn\_cidr\_block](#input\_gcn\_cidr\_block) | Customer GCN CIDR block | `any` | n/a | yes |
| <a name="input_gcn_management"></a> [gcn\_management](#input\_gcn\_management) | Management GCN outputs | `any` | n/a | yes |
| <a name="input_health_check_ip_source"></a> [health\_check\_ip\_source](#input\_health\_check\_ip\_source) | Source IP from Google for Load Balancer Heatlh Checks | `list(string)` | <pre>[<br/>  "35.191.0.0/16",<br/>  "130.211.0.0/22",<br/>  "209.85.152.0/22",<br/>  "209.85.204.0/22",<br/>  "169.254.169.254/32"<br/>]</pre> | no |
| <a name="input_log_aggregation_interval"></a> [log\_aggregation\_interval](#input\_log\_aggregation\_interval) | Flow log aggregation interval | `string` | `"INTERVAL_5_SEC"` | no |
| <a name="input_log_flow_sampling"></a> [log\_flow\_sampling](#input\_log\_flow\_sampling) | Flow log sampling rate | `number` | `0.5` | no |
| <a name="input_router_asn"></a> [router\_asn](#input\_router\_asn) | ASN number for the customer router BGP configuration | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Dictionary of subnets to be created | `any` | n/a | yes |
| <a name="input_tier_to_archive_days"></a> [tier\_to\_archive\_days](#input\_tier\_to\_archive\_days) | Tier to archive after days since modification greater than | `number` | `30` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Whether or not versioning is enabled for GCS bucket | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_firewall"></a> [customer\_firewall](#output\_customer\_firewall) | #### Firewall |
| <a name="output_customer_router"></a> [customer\_router](#output\_customer\_router) | #### Filestore #### Gateways |
| <a name="output_service-account"></a> [service-account](#output\_service-account) | ###  Service Account |
| <a name="output_subnet_development_1a"></a> [subnet\_development\_1a](#output\_subnet\_development\_1a) | n/a |
| <a name="output_subnet_development_1b"></a> [subnet\_development\_1b](#output\_subnet\_development\_1b) | n/a |
| <a name="output_subnet_development_1c"></a> [subnet\_development\_1c](#output\_subnet\_development\_1c) | n/a |
| <a name="output_subnet_edge_1a"></a> [subnet\_edge\_1a](#output\_subnet\_edge\_1a) | n/a |
| <a name="output_subnet_edge_1b"></a> [subnet\_edge\_1b](#output\_subnet\_edge\_1b) | n/a |
| <a name="output_subnet_edge_1c"></a> [subnet\_edge\_1c](#output\_subnet\_edge\_1c) | n/a |
| <a name="output_subnet_production_1a"></a> [subnet\_production\_1a](#output\_subnet\_production\_1a) | #### Subnets |
| <a name="output_subnet_production_1b"></a> [subnet\_production\_1b](#output\_subnet\_production\_1b) | n/a |
| <a name="output_subnet_production_1c"></a> [subnet\_production\_1c](#output\_subnet\_production\_1c) | n/a |
| <a name="output_subnet_quality_assurance_1a"></a> [subnet\_quality\_assurance\_1a](#output\_subnet\_quality\_assurance\_1a) | n/a |
| <a name="output_subnet_quality_assurance_1b"></a> [subnet\_quality\_assurance\_1b](#output\_subnet\_quality\_assurance\_1b) | n/a |
| <a name="output_subnet_quality_assurance_1c"></a> [subnet\_quality\_assurance\_1c](#output\_subnet\_quality\_assurance\_1c) | n/a |
| <a name="output_vpc_customer"></a> [vpc\_customer](#output\_vpc\_customer) | ### GCN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
