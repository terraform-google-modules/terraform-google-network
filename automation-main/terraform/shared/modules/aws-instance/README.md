aws-instance Module
===================

This module creates an AWS EC2 Instance on demand.

**Table of Contents:**

[[_TOC_]]

Implementation of aws-instance Module
-------------------------------------

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the terraform state files

Module Variables - Required
---------------------------

| Variable Name                        | Description |
| ------------------------------------ | ----------- |
| aws_region                           | AWS Region e.g. `us-gov-west-1` [amazon region documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html) |
| build_user                           | User id of individual executing terraform; must be defined for auditing purposes e.g. `i12345` |
| ec2_key                              | Name of the AWS keypair to use for the instance |
| iam_instance_profile                 | IAM Profile to attach to the instance |
| module_dependency                    | Used by root modules to create a dependency for order of operation purposes |
| search_ami_name                      | The expression to look for the AMI that the instance will use e.g. `Golden-SHC-RHEL-7.7-Base-V*` |
| search_ami_owner_id                  | The account id of the AMI owner |
| security_group_ids                   | List of Security group IDs to apply to the Instance |
| subnet_id                            | Subnet ID where the instance should live |

Module Variables - Optional
---------------------------

| Variable Name                        | Default    | Description | Value Options |
| ------------------------------------ | ---------- | ----------- | ------------- |
| instance_type                        | `t3.micro` | AWS Instance type | [amazon ec2 instance types documentation](https://aws.amazon.com/ec2/instance-types/) |
| host_id                              | null       | Specifies dedicated host to be deployed to. | string |
| disable_api_termination              | `false`    | Prevent destroy in AWS Console | `true` - disable ability to terminate resource on the AWS console <br/><br/> `false` - allow termination on the AWS console |
| enable_state_recovery                | `false`    | Enables cloudwatch hardware state recovery | `true` - cloudwatch hardware state recovery enabled <br/><br/> `false` - cloudwatch hardware state recovery disabled |
| monitoring                           | `false`    | Enables detailed cloudwatch monitoring | `true` - detailed monitoring enabled <br/><br/> `false` - detailed monitoring disabled |
| placement_group                      | ""         | Which placement group to put the instance in | |
| root_type                            | `standard` | Type of Root volume | `standard`, `gp2`, `io1`, `sc1`, or `st1` |
| root_size                            | `100`      | Size of Root volume in GiB | string |
| root_delete_on_termination           | `false`    | Deletes root volume on instance termination | `true` - delete root volume on instance termination <br/><br/> `false` - keep root volume on instance termination |
| root_encrypted                       | `false`    | Encrypt the root volume | `true` - encrypt the root volume <br/><br/> `false` - do not encrypt the root volume |
| associate_public_ip_address          | `false`    | Create Instance with a dynamically assigned public IP address | `true` - dynamically assign public IP address <br/><br/> `false` - do not assign public IP address |
| associate_elastic_ip_address         | `false`    | Create Instance with an Elastic IP address | `true` - create and assign elastic IP address <br/><br/> `false` - do not create/assign elastic IP address |
| ipv6_address_count                   | null       | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet. | string |
| tenancy                              | null       | (Optional) The tenancy of the instance. Available values: default, dedicated, host | string |
| source_dest_check                    | true       | If true, AWS enforces layer3 source/destination checks on traffic passing through the network interface | boolean |
| additional_volumes | `{}` | Map of additional volumes to attach to instance | `map(object({ az = string, size = number }))` where dict key is the device name. i.e. sda, sdb, etc |
| route53_associate_private_ip_address | `false`    | Create DNS A record for instance ID in passed Route53 zone | `true` - create DNS A record for instance ID <br/><br/> `false` - do not create DNS A record for instance ID |
| route53_zoneid                       | ""         | Zone ID for the Route53 zone for creating DNS records | string |
| route53_ttl                          | `300`      | Value for Route53 TTL in seconds | string |
| route53_associate_cname              | `false`    | Only if route53_associate_private_ip_address is set to true, create standard CNAME for created DNS A record using passed instance tags, instance private ip CIDR, and availability zone | `true` - create standard CNAME for created DNS A record using passed instance tags <br/><br/> `false` - do not create CNAMES for instance <br/><br/> e.g. Splunk Indexer: `indexer-splunk123a` |
| route53_additional_cnames            | `[]`       | Only if route53_associate_private_ip_address is set to true, additional list of custom CNAMEs to provision for created DNS A record | list(string) |
| http_tokens                          | `optional` | If set to "required", it forces EC2 Instance Metadata service v2 (IDMSv2) to be used, otherwise IDMSv1 is set by default | `optional` or `required` |

EC2 Instance Tagging Variables
------------------------------

**Note:** required tagging inputs are only required when `null-context` not in use

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| tag_business | | (**Required**) Line of business which the resource is related to | e.g. `ns2`, `ibp`, `scp`, `sac`, `hcm` |
| tag_customer | | (**Required**) Customer that uses the deployed system | e.g. `management`, `customer00006` |
| tag_description | | (**Required**) Friendly description of the purpose of the system | |
| tag_environment | | (**Required**) Related management plane | e.g. `staging`, `production`, `management` |
| tag_name | | (**Required**) AWS Tag Name of the instance. Conventionally a single word category the instance belongs to. A random hex string will be added to ensure uniqueness | See [docs](https://gitlab.core.sapns2.us/golden-ami-dev/ns2-build-documentation/-/blob/master/GUIDANCE-INFRASTRUCTURE.md#required-tags-instance-specific) for details. e.g. `security` for security tooling instances, `database` for a database instance |
| tag_owner | | (**Required**) Email address directing communication for that party responsible for the system | e.g. `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com` |
| tag_platform | | (**Required**) Used by the Asset Management team | e.g. `licensed` (Windows) or `unlicensed` (Red Hat Linux) |
| tag_productname | | (**Required**) Application/product name being deployed | e.g., `hana`, `nessus`, `concourse` |
| tag_managedby | `terraform` | Indicates what technology is used to continuously configure the resource | e.g. `terraform`, `ansible`, `chef` |
| tag_patchgroup | | (Optional) Group of systems that should be patched together during scheduled maintenance windows | |
| tag_productcluster | | (Optional) A more granular name of the specific cluster/deployment of a product when deploying the same product multiple times in a single hosted zone and clarification is needed | e.g., `pki` a second Hashicorp Vault deployed specifically for PKI |
| tag_productcomponent | | (Optional) The name of the subcomponent of the product only when product is broken into multiple subcomponents | e.g., `web`, `worker` (Concourse), `indexer` (Splunk) |
| tag_productvendor | | (Optional) The name of the vendor/brand of the product | e.g., `tenable`, `sap`, `hashicorp` |
| tag_productversion | | (Optional) Specific version or variant of product | e.g. `8.1.2`, `R40`, `v3.0` |
| tag_scangroup | | (Optional) Group of systems that should be scanned together during scheduled scan windows | |

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
