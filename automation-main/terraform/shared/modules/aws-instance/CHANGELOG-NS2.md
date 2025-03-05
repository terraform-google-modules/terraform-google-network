# Latest Version
3.2.10 (0.13-000041)

# Version History
## Version 3.2.10 (0.13-000041) (2024-10-04) (i744693)
### Bugfix - Fix Validation Message
* Fix validation message from recent changes to metadata options

## Version 3.2.9 (0.13-000040) (2024-07-25) (i548447)
### Enhancement - Add tenancy input
* Add ability to set tenancy input, defaults to null (default)

## Version 3.2.8 (0.13-000039) (2023-10-03) (i511522)
### Bugfix - us-east-2 i3 instance recovery not supported
* Add us-east-2 region to list of regions without instance recovery cloudwatch alarm actions

## Version 3.2.7 (0.13-000038) (2023-08-22) (i548472)
### Enhancement - add security boundary tag
* Add security boundary tag

## Version 3.2.7 (0.13-000037) (2023-06-14) (c5309336)
### Enhancement - Null Context Update
* Updated `terraform-null-context` to use `terraform-null-context/modules/legacy`

## Version 3.2.6 (2023-03-22) (c5355631)
### Feature - Add description to cloudwatch alarms to include cname
* Fixed error in version 3.2.4
* Add description to cloudwatch alarms to include cname

## Version 3.2.5 (2023-03-17) (c5309377)
### Bugfix - Revert change from 3.2.4
* Reverts the change made in 3.2.4 because it failed to deploy in production

## Version 3.2.4 (2023-03-06) (c5355631)
### Feature - Add description to cloudwatch alarms to include cname
* Add description to cloudwatch alarms to include cname

## Version 3.2.3 (2023-02-06) (i513825)
### Bugfix - PatchGroup via null-context
* Remove logic that attempts to automatically enforce the `PatchGroup` tag based on this tag's presence within `null-context`
* On net-new resources due to the `ProvisionDate` tag, tags are actually "known after apply"
* Meaning, Terraform will throw an error as it cannot calculate if the dictionary key exists prior to apply
* Tradeoff here is that in order to enforce `PatchGroup` tags for modules that exclusively leverage `context` for tagging, one must manually configure this tag to be enforced via the `enforce_tags` input

## Version 3.2.2 (2023-02-02) (i513825)
### Bugfix - PatchGroup
* Update `Patch Group` tag to `PatchGroup` to ensure compatibility with all AWS services now that AWS supports it
* Enforce `PatchGroup` tag if either passed via `var.tag_patchgroup` or via context

## Version 3.2.1 (2023-01-31) (c5337390)
### Bugfix - Patch Group Tag Enforcement logic fix
* When a Patch Group was passed and a context too, it would cause a bug

## Version 3.2.0 (2023-01-20) (i513825)
### Feature - Optional Tag Enforcement
* Add resource to optionally enforce specific EC2 tags via Terraform

### Feature - ResourceLock tag
* Add optional variable to specify an enforced `ReleaseLock` tag which can be used to control package installation for system

## Version 3.1.0 (2022-10-31) (i513825)
### Feature - Auto-reboot instance checks alarm
* Add optional support for Cloudwatch alarm that will auto-reboot instance if EC2 instance checks fail

## Version 3.0.0 (2022-09-15) (c5309377)
### Enhancement - Make gp3 the default root block device volume
* Replaces `standard` with `gp3` as is recommended by AWS as `standard` is considered legacy

## Version 2.0.27 (2022-08-05) (c5337390)
### Enhancement - Add the subnet_id as an export
* Added the subnet_id as an export which is useful to send to the new aws-endpoint-services-multitarget

## Version 2.0.26 (2022-07-16) (c5337390)
### Bug - Remove support for instance_metadata_tags
* aws provider version of 3.72 is needed for instance_metadata_tags which is higher than some environments
* Removed the ability to enable instance_metadata_tags

## Version 2.0.25 (2022-07-16) (c5337390)
### Enhancement - Add support for instance_metadata_tags
* Added the ability to enable instance_metadata_tags

## Version 2.0.24 (2022-07-07) (i513825)
### Bugfix - Elastic IP output resource importation issues
* Fixed bug introduced by `2.0.23` where conditional output logic does not properly function within `terraform import` statements due to the lack of error handling
* Terraform does not properly render the non-existence of the `aws_eip_association.instance[0]` conditional resource during imports when not present, for that reason a `try()` function call has been added to ensure a value is always chosen for that condition even when an EIP is not being created&associated for an instance

## Version 2.0.23 (2022-07-07) (i568675)
### Bugfix - Public IP output when Elastic IP is associated
* Fixed an issue where public IP address output did not match Elastic IP address when associated
* Add conditional statement to module output which includes the external ip from the `aws_eip_association`
* This issue would require running `terraform apply` twice to ensure correct the public IP output value was stored in state files

## Version 2.0.22 (2022-04-01) (i511522)
### Bugfix - Cloudwatch alarm action for i3 instances in select AWS regions
* Drop the recover action from the Cloudwatch metric alarm for i3* instances from the following AWS regions:
  * `ap-southeast-2`
  * `ca-central-1`
  * `eu-west-2`

## Version 2.0.21 (2022-03-01) (i511522)
### Enhancement - Add additional EBS volume support
* Added additional EBS volume support for IaaS capabilities

## Version 2.0.20 (2021-11-03) (i511522)
### Enhancmenet - Cloudwatch alarm ignore ok_action changes
* Added ignore ok_actions to lifecycle policy

## Version 2.0.19 (2021-10-25) (i513825)
### Bugfix - Documentation
* Improve README

## Version 2.0.18 (2021-09-28) (i513825)
### Bugfix - Enforce Name tag suffix
* Ensure `Name` tag is constructed with proper `/<RANDOM>` suffix whether it is passed via `tag_name` input or via `null-context`

## Version 2.0.17 (2021-08-23) (i513825)
### Bugfix - Context naming flags
* Pass additional flags to EIP and CloudWatch alarm context to override their name and skip checks to avoid failures on long names

## Version 2.0.16 (2021-07-23) (i513825)
### Bugfix - Optional IAM instance profile
* Ensure the `iam_instance_profile` variable has a default set making the variable optional
* The `aws_instance` does not require an IAM instance profile be passed
* This allows this module to support use cases where an EC2 instance is to be created without an IAM profile

## Version 2.0.15 (2021-06-04) (c5309377)
### Bugfix - Copy and paste error
* Fixes a copy and paste error in validating that the Name is set for an instance

## Version 2.0.14 (2021-05-21) (i513825)
### Bugfix - Add default for `instance_initiated_shutdown_behavior`
* Provided default for `aws_instance` resource input `instance_initiated_shutdown_behavior`
* This prevents an error preventing Terraform from properly executing

## Version 2.0.13 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 2.0.12 (0.13-000013) (2021-04-30) (i513825)
### Enhancement - Add DNSZone tag
* Apply `DNSZone` tag to instances when flags passed to ensure record creation in Route53

### Bugfix - Conditional Cnames tag
* Fix logic so that `Cnames` tag only gets added when records are actually being created in Route53

## Version 2.0.11 (0.13-000012) (2021-03-01) (i868402)
### Enhancement - Example Root Update
* Allows multiple example roots to be run concurrently
* Proper testing of placement groups (requires m5.large)
* Proper output of null context examples

## Version 2.0.10 (0.13-000011) (2021-02-26) (i868402)
### Enhancement - Ignore Root Volume tags
* Ignore volume and root volume tags
* Raises minimum aws provider to 3.24

## Version 2.0.9 (0.13-000010) (2021-02-10) (i513825)
### Enhancement - Support AMI ID filter option
* Add optional configuration to search for AMIs with the `image-id`

## Version 2.0.8 (0.13-000009) (2021-02-08) (i868402)
### Enhancement - Support Dedicated Hosts
* Add option to deploy on dedicated hosts.

## Version 2.0.7 (0.13-000008) (2021-02-08) (c5309377)
### Enhancement - Set default instance to t3a.small
* Upgrade to t3a.small by default

## Version 2.0.6 (0.13-000007) (2021-02-07) (i868402)
### Bugfix - Fixed name-passed regression bug
* Fixed bug where code would attempt to enumerate an empty tuple.
### Enhancement - Updated example-root
* Update example-root deployment with static private IP address

## Version 2.0.5 (0.13-000006) (2021-02-04) (i513825)
### Enhancement - Add optional static private IP address input
* Added optional input to manually set a static private IP address for the EC2 instance

### Bugfix - Permit context Name override
* Adjust logic so the `Name` tag can be overridden with `null-context`

## Version 2.0.4 (0.13-000005) (2020-01-05) (i868402)
### Enhancement - DNS CNAMEs
* Use instance ID instead of last octet for auto-generated CNAME to prevent collisions
* Additional CNAMEs now independent from Auto-Generated CNAMEs

## Version 2.0.3 (0.13-000004) (2020-12-17) (i868402)
### Enhancement - null-context integration
* Improve on null-context integration
* Updated example_root test module

## Version 2.0.2 (0.13-000003) (2020-12-14) (c5309336)
### Enhancement
* Added depends on to allow better respurce deletion

## Version 2.0.1 (0.13-000002) (2020-11-20) (i868402)
### Enhancement - Remove terraform0.11 syntax
* Gets rid of the terraform0.11 syntax warning.
* Applied terraform fmt

## Version 2.0.0 (0.13-000001) (2020-10-29) (i513825)
### Enhancement - set minimum Terraform version for module
* Set minimum Terraform version to 0.13+ due to optional `null-context` support relies on `count` for modules

### Enhancement - expanded `null-context` support
* Added tagging for additional CNAMEs
* Improved optional context usage logic

## Version 0.12-000028 (2020-10-23) (i513825)
### Enhancement - optional support `null-context`
* Added logic to optionally support `null-context` module input without changing current behavior

### Enhancement - support multi-command linux bootstrap
* Added logic to support passing a list of commands to execute for linux machine bootstrapping

## Version 0.12-000027 (2020-10-23) (i513825)
### Bugfix - ignore EC2 recovery for CloudWatch metric alarm under specific conditions
* Due to current lack of AWS support, EC2 recovery for the CloudWatch metric alarm has been disabled for the following conditions:
    * EC2 instance provisioned in AWS Commercial Cloud

## Version 0.12-000027 (2020-10-22) (i513825)
### Enhancement - support different AWS partitions
* Dynamically grab AWS partition value for CloudWatch alarm creation

### Bugfix - remove `create_before_destroy` from route53 record creation
* Prevent error where Terraform will try to create a duplicate record in a re-ordered list

## Version 0.12-000026 (2020-10-22) (c5295459)
### Enhancement - Add EC2 instance ARN to outputs
* Add EC2 instance ARN to module outputs

## Version 0.12-000025 (2020-08-14) (i868402)
### Documentation - Version and Validation
* Validated and added minimum versions

## Version 0.12-000024 (2020-08-05) (i513825)
### Bugfix - route53 record creation references instance tags
* Fixes bug where a change to EC2 instances tags are ignored for the instances but picked up by Route53 records
* Route53 record creation now references the EC2 instance resource and not from the module inputs
    * This means that Route53 records will only update when the tags on the intance update

## Version 0.12-000023 (2020-07-28) (c5309377)
### Feature
* Add an output that contains all of the instances IPv6 records
* If route53 records are requested, also add an entry for IPv6
* Allow passing a count of IPv6 addresses to be attached to an instance.
  Defaults to null and will follow the subnet settings, set to 0 to disable
  IPv6 for an instance.

  If you want automatic creation of Route 53 AAAA records for an instance, this
  variable needs to be set to 1, even if the default for the subnet is to
  create and attach an IPv6 address.

## Version 0.12-000022 (2020-07-06) (i513825)
### Bugfix - additional CNAME output
* Properly appends Route53 FQDN to end of additional CNAME records in module output

## Version 0.12-000021 (2020-06-11) (i868402)
### Enhancement - source destination checking
* Adds source destination checking option to aws-instances

## Version 0.12-000020 (2020-04-29) (i513825)
### Bugfix - Route53 A record now created using `instance-id`
* Route53 A record now created using `instance-id` as opposed to using the `Name` tag

### Bugfix - renamed `name` input variable to `tag_name`
* Renamed `name` input variable to `tag_name` to prevent confusion that the `name` attribute applies to anything other than the `Name` tag.

### Enhancement - added optional instance tags
* `tag_productcluster` - A more granular name of the specific cluster/deployment of a product when deploying the same product multiple times in a single hosted zone and clarification is needed. e.g., `pki` a second Hashicorp Vault deployed specifically for PKI
* `tag_productcomponent` - The name of the subcomponent of the product only when product is broken into multiple subcomponents. e.g., `web`, `worker` (Concourse), `indexer` (Splunk)
* `tag_productvendor` - The name of the vendor/brand of the product e.g., `tenable`, `sap`, `hashicorp`

### Enhancement - added Route53 CNAME generation support
* Added additional `route53_associate_cname` variable to turn on/off the auto-creation of a standard CNAME for instance to its managed A record using template of its passed instance tags, private ip CIDR, and availability zone.
* Added additional `route53_additional_cnames` variable list to allow for the passing of additional custom CNAMEs to create in addition to the standard CNAME

## Version 0.12-000019 (2020-05-04) (i868402)
### Enhancement - tag description
* Changed formatting of the tag description to be more inline wih all other options.

## Version 0.12-000018 (2020-04-21) (i513825)
### Enhancement - refactored bootstrap feature
* Bootstrap feature is now fully optional and previous inputs `git_token` and `git_name` can be simply ignored unless feature is selectively turned on with certain settings
* Preserved ability to inject custom base64encoded string via userdata to execute during cloud-init phase of first boot
* Refactored pre-built bootstrap script option with optional features
*   Accept git credentials and custom repo/pathing to execute custom passable `bootstrap_command` on the system in the root of the cloned repository at first boot (takes on any single line bash command)

## Version 0.12-000017 (2020-04-27) (i513825)
### Bugfix - added `create_before_destroy` lifecycle to instance route53 entry
* Prevents bug where existing instance is re-created from a subnet change or other replacement-forcing alteration and the route53 record is duplicated instead of updated.

## Version 0.12-000016 (2020-04-19) (i513825)
### Enhancement - added `availability_zone` output
* Adds instance `availability_zone` to module outputs

## Version 0.12-000015 (i513825)
### Enhancement - refactored instance tagging
* Module now has fully built out tagging mechanics consistent with up to date standards in CONTRIBUTING-TERRAFORM.md documentation.
* Enforces mandatory set of company tags on creation to ensure consistency accross the organization

### Bugfix - optional tags
* Optional tags now can simply be ignored and they will not be applied to the instance
* Fixes having to pass a placeholder value `UNTAGGED` or an empty tag value

### Bugfix - cloudwatch managed by ansible
* Module ignores changes to cloudwatch alarm fields as these are confirmed to be managed by ansible.
* If not, terraform will continue to stomp on changes ansible is trying to enforce.

## Version 0.12-000014 (i513825)
### Bugfix - route53 record creation fix
* Creation of an A record in route53 now properly replaces `/` characters with `-`

## Version 0.12-000013 (i513825)
### Enhancement - Added passable variable for `Patch Group`
* Added passable variable for `Patch Group` to be able to put instances in various machine groups that will have configured patches applied against them at pre-configured intervals

## Version 0.12-000012 (i516349)
### Enhancement - Placement Groups
* Removed `VPC` string in `Description` tag

## Version 0.12-000011 (i868402)
### Enhancement - Placement Groups
* Add support for placement groups

## Version 0.12-000010 (i868402)
### Enhancement - ignore userdata
* Remove userdata from the keepers
* This will require removing the userdata entry from keepers in existing state files

## Version 0.12-000009 (i868402)
### Enhancement - refactor
* Removed providers from the module itself.  This causes problems in root modules when destroy code.
* removed availability zone tag
* Created easier testing steps
* example root now creates its own environment

## Version 0.12-000008 (c5295459)
### Enhancement - new options
* Added options for Root drive encryption and termination options

## Version 0.12-000007 (c5295459)
### Enhancement - route53 update
* Create ability for Route53 private record creation
* Assume default of A record and TTL of 5 minutes
* Defaults added in dependencies

## Version 0.12-000006 (i868402)
### Bugfix - enhancements
* Missing variable declaration for customer tag
* Changed Image tag to be AMI name
* Minor documentation changes

## Version 0.12-000005 (i868402)
### Enhancement - Refactor
* Refactored list of applied tags
* Moved instance_map to seperate variables

## Version 0.12-000004 (i868402)
### Bugfix - Hardcoded regions
* Changes region to variable in dependencies

## Version 0.12-000003 (i868402)
### Enhancement - Customer Bootstrap
* Allows for custom base64 encode bootstrap

## Version 0.12-000002 (i868402)
### Bugfix - Invalid Usage of Count
* Terraform error if the environment had other changes pending
* resolved by changing map attribute to direct input variable

### Bugfix -  AMI Update and Destroy
* AMI update would force destroy the RandomID
* Resolved by ignoring AMI

### Bugfix -  EBS Optimization
* Force update if EBS Optimzation.
* AWS behavior for EBS Optimzation changes depending on type
* Resolve by ignoring EBS Optimization

## Version 0.12-000001 (i868402)
### Initial version established with the following features
* Creates Instance
* Creates and attaches EIP on demand
* Creates Cloudwatch Hardware Autorecovery on demand
