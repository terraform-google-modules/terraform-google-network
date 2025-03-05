azure-linux-virtual-machine Module
==================================

This module creates an Azure Linux Virtual Machine on demand.

**Table of Contents:**

[[_TOC_]]

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 0.13+
* Azure priviledges to manage the necessary services

Module Variables - Required
---------------------------

| Variable Name                        | Description |
| ------------------------------------ | ----------- |
| name | Name of the virtual machine. Conventionally a single word category the instance belongs to. A random hex string will be added to ensure uniqueness <br/><br/> See [docs](https://gitlab.core.sapns2.us/golden-ami-dev/ns2-build-documentation/-/blob/master/GUIDANCE-INFRASTRUCTURE.md#required-tags-instance-specific) for details. e.g. `security` for security tooling instances, `database` for a database instance |
| location | Azure location where the Linux Virtual Machine should exist |
| resource_group_name | Name of the Resource Group in which the Linux Virtual Machine should be exist |
| build_user | User id of individual executing terraform; must be defined for auditing purposes e.g. `i12345` |
| module_dependency | Used by root modules to create a dependency for order of operation purposes |
| public_key | The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format |
| search_image_name | The expression to look for the image that the virtual machine will use |
| image_resource_group_name | Name of the Resource Group in which the Linux Virtual Machine Image exists |
| subnet_id | Subnet ID where the virtual machine should live |
| zone | The Zone in which this Virtual Machine should be created (e.g. "1", "2", "3") |

Module Variables - Optional
---------------------------

| Variable Name                        | Default    | Description |
| ------------------------------------ | ---------- | ----------- |
| size | `Standard_B1s` | SKU which should be used for the Virtual Machine |
| admin_username | `cloud-user` | The username of the local administrator used for the Virtual Machine |
| system_assigned_identity_permissions | `{}` | A map of role definition names and their scope to assign to the System Managed Identity. Scope can be set to 'self' to apply permissions scoped to this virtual machine. |
| user_managed_identity_ids | `[]` | A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine |
| dedicated_host_id | null | Dedicated Host Id to launch Virtual Machine on |
| proximity_placement_group_id | null | The ID of the Proximity Placement Group which the Virtual Machine should be assigned to |
| associate_public_ip_address | `false` | Create Network Interface with a public IP address |
| associate_static_public_ip_address | `false` | Create Network Interface with a Static public IP address |
| network_security_group_id | null | Network Security group ID to apply to the Virtual Machine |
| application_security_groups | `{}` | Map of Application Security group ID to apply to the Virtual Machine |
| static_private_ip_address | null | Manually set a static private IP address |
| encryption_at_host_enabled | `true` | Whether to ensure all of the disks (including the temp disk) attached to this Virtual Machine are encrypted by enabling EncryptionAtHost |
| os_disk_storage_account_type | `Standard_LRS` | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS |
| os_disk_caching | `ReadWrite` | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite |
| os_disk_size_gb | `100` | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from |
| dns_associate_private_ip_address | `false` | Create DNS A record for virtual machine ID in supplied DNS Zone |
| dns_zone | `""` | DNS Zone for creating DNS records. Must be set when `dns_associate_private_ip_address` is set to `true` |
| dns_ttl | `300` | Value for TTL in seconds |
| dns_associate_cname | `false` | Only if `dns_associate_private_ip_address` is set to `true`, create standard CNAME for created DNS A record using passed virtual machine tags |
| dns_additional_cnames | `[]` | Only if `dns_associate_private_ip_address` is set to `true`, additional list of custom CNAMEs to provision for created DNS A record |

Virtual Machine Tagging Variables
---------------------------------

**Note:** required tagging inputs are only required when `null-context` not in use

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| tag_business | | (**Required**) Line of business which the resource is related to | e.g. `ns2`, `ibp`, `scp`, `sac`, `hcm` |
| tag_customer | | (**Required**) Customer that uses the deployed system | e.g. `management`, `customer00006` |
| tag_description | | (**Required**) Friendly description of the purpose of the system | |
| tag_environment | | (**Required**) Related management plane | e.g. `staging`, `production`, `management` |
| tag_owner | | (**Required**) Email address directing communication for that party responsible for the system | e.g. `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com` |
| tag_platform | | (**Required**) Used by the Asset Management team | e.g. `licensed` (Windows) or `unlicensed` (Red Hat Linux) |
| tag_productname | | (**Required**) Application/product name being deployed | e.g., `hana`, `nessus`, `concourse` |
| tag_managedby | `terraform` | Indicates what technology is used to continuously configure the resource | e.g. `terraform`, `ansible`, `chef` |
| tag_patchgroup | | (Optional) Group of systems that should be patched together during scheduled maintenance windows | |
| tag_productcluster | | (Optional) A more granular name of the specific cluster/deployment of a product when deploying the same product multiple times in a single hosted zone and clarification is needed | e.g., `pki` a second Hashicorp Vault deployed specifically for PKI |
| tag_productcomponent | | (Optional) The name of the subcomponent of the product only when product is broken into multiple subcomponents | e.g., `web`, `worker` (Concourse), `indexer` (Splunk) |
| tag_productvendor | | (Optional) The name of the vendor/brand of the product | e.g., `tenable`, `sap`, `hashicorp` |
| tag_productversion | | (Optional) Specific version or variant of product | e.g. `8.1.2`, `R40`, `v3.0` |

Bootstrap Variables
-------------------

The below variables pertain to the ability to inject a bootstrap script into the instance via userdata and execute it on first boot. This feature is fully optional and by default is turned off. It is recommended that this feature is to be used sparingly and only turned on selectively for certain use cases due to its idempotency limitations and posed security risks.

**Note 1:** Changes to this script after initial instance creation are not idempotent and will not be reflected or effect the running instance in any way. This will only fire once upon initial instance provisioning.

**Note 2:** It is strongly guided for security purposes that any bootstrap use case that requires the injection of credentials contain only dedicated service account credentials with appropriately restricted permissions.

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| bootstrap_enable | `false` | Flag to turn instance bootstrap process via userdata on/off | `true` - enables boostrap <br/><br/> `false` - disables bootstrap |
| custom_bootstrap | (Optional) When defined and `bootstrap_enable` is set to `true`, allows for a custom base64 encoded bootstrap string to be applied to the instance via userdata | e.g. `ALNSLSDNFSFNSDKFNKJ...` (any [base64 encoded](https://www.terraform.io/docs/configuration/functions/base64encode.html) string) |
| git_repository | | (Optional) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git repository to download, leave out 'http(s)' url prefix | e.g. `ns2-scp-dev.sapns2.us/golden-ami-dev/ansible-roles.git` |
| git_branch | `master` | When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, specific branch of git repository to download | |
| git_repository_path | platform `linux` -> `/temp/temprepo` <br/><br/> platform `windows` -> `C:\\Windows\\Temp\\temprepo` | (Optional) When bootstrap `true` selected, path on system where to clone git repository to (for windows, must escape backslash `\\`) | |
| git_repository_cleanup | `true` | (Optional) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, flag to tell boostrap process to removed cloned repository from system when finished | `true` - remove cloned repository after bootstrap execution <br/><br/> `false` - leave cloned repository on system after bootstrap execution |
| git_name | | (Optional) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git username of service account to download repositories <br/>(**Note:** it is strongly recommended not to use a personal account here for security purposes) | e.g. `svc-terraform` |
| git_token | | (Optional) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git access token for service account to download repositories <br/>(**Note:** it is strongly recommended not to use personal account credentials here for security purposes) | [how to setup gitlab access token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) |
| bootstrap_commands | | (Optional) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, list of bash commands to execute (runs within root of downloaded git repository if specified) | e.g. `bash /PATH/SCRIPT.sh`, `ansible-playbook playbooks/PLAYBOOK.yml` |

### Examples:

The below example shows how one might clone a desired repository and execute any ansible playbook on first boot as a part of the bootstrap process. Specifically, this example shows how to automatically configure the new instance to trust a specified HashiCorp Vault SSH Engine to sign client SSH keys, thus allowing clients remote access to the system by leveraging Vault. Please note that this configuration is one example, but can adjusted to execute other playbooks to fit other needs.

```
module "EXAMPLE_vault" {
  source = "PATH/TO/modules/aws-instance"
  ...
  # Bootstrap Variables (can be removed entirely if not used)
  bootstrap_enable = true
  git_repository = "ns2-scp-dev.sapns2.us/golden-ami-dev/ansible-roles.git"
  git_name = "svc-terraform"
  git_token = "<GIT_ACCESS_TOKEN>"
  bootstrap_commands = ["ansible-playbook -i localhost, -c local playbooks/vault/vault-configure-host.yml -e vault_ssh_host_vault_url=https://VAULT_IP_ADDRESS:8200 -e vault_ssh_host_ssh_engine=VAULT_SSH_ENGINE"]
  ...
}
```

Another example shows how one might simply execute any single line bash command on the target system at first boot.

```
module "EXAMPLE_instance" {
  source = "PATH/TO/modules/aws-instance"
  ...
  # Bootstrap Variables (can be removed entirely if not used)
  bootstrap_enable = true
  bootstrap_commands = [
    "echo 'Hello World!'",
    "echo 'Hello Again!'"
  ]
  ...
}
```

Lastly, the user may with to pass to the module their own custom boostrap script to be executed via userdata. The custom script must be passed as a single [base64 encoded](https://www.terraform.io/docs/configuration/functions/base64encode.html) string.

```
module "EXAMPLE_instance" {
  source = "PATH/TO/modules/aws-instance"
  ...
  # Bootstrap Variables (can be removed entirely if not used)
  bootstrap_enable = true
  custom_bootstrap = "ASDLJNFDLSKFSDFSSDFSDFDSBVR..."
  ...
}
```

Author Information
------------------

* Devon Thyne (devon.thyne@sapns2.com)
* Louis Lee (louis.lee@sapns2.com)
