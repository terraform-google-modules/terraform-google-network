# Latest Version
4.0.0

# Version History
## Version 4.0.0 (2023-06-12) (c5309336)
### Moved - Created Legacy-Null-Context
* Created a submodule 'Legacy-Null-Context' to pin the latest version of Null Context so that a new version of Null Context can be created without breaking infrastructure.

## Version 3.3.10 (2023-02-15) (i513825)
### Enhancement - Known Tags
* Create separate output for `tags_known` which exclude tag keys we know to always be "known after apply"
* Purpose of this output is for use-cases where null-context tags which to be passed to dynamic automation using loops
* Without this, it is a limitation on part of Terraform to key dictionaries on values "known after apply"

## Version 3.3.9 (2022-09-27) (c5309336)
### Enhancement - Moved `context` into its own file
* Created file `variables-context.tf` with just the context variable definition. This allows for easier copying and
  updating in the future.

## Version 3.3.8 (2022-03-24) (i511522)
## Enhancement - Add 63 char limit to gcp labels
* Added 63 char limit to gcp labels

## Version 3.3.7 (2022-03-07) (i511522)
### Enhancemnt - GCP label support
* Added local gcp_labels which formats tags for gcp
* Added labels output

## Version 3.3.6 (2021-12-21) (i868402)
### Enhancement - Remove AWS provider
* Remove uneeded AWS provider

## Version 3.3.5 (2021-09-14) (i513825)
### Bugfix - Increase minimum resource name length constraints
* `64` -> `128` enforced resource naming length constraint

## Version 3.3.4 (2021-09-13) (c5309377)
### Enhancement - Update sub_boundary to minor_security_boundary
* This updates the variable name sub_boundary to minor_security_boundary

## Version 3.3.3 (2021-06-08) (i513825)
### Enhancement - Parent DNS Domain Outputs
* Added output information for the configured internal and external parent domain defaults
* Added documentation in the README for the `domain` output and how it works

### Enhancement - Prefix Label Mapping Bottom
* Added `bottom` category to `prefix_label_mapping` output to allow users to more easily reference the constructed prefix with the full label order
* Added documentation in the README for updated `prefix_label_mapping` functionality

## Version 3.3.2 (2021-05-10) (c5309377)
### Bugfix - Update required_providers for terraform
* update versions.tf to the format required by Terraform 0.13 (and later)

## Version 3.3.1 (2021-02-12) (i513825)
### Bugfix - added missing error handling for prefix_label_mapping output
* Added error handling that catches `null` values and prevents errors within `prefix_label_mapping` logic

## Version 3.3.0 (2021-02-09) (i513825)
### Enhancement - added prefix_label_mapping output
* Added `prefix_label_mapping` that expresses the various tiers of name prefixing with both formatted and/or friendly versions

## Version 3.2.1 (2020-12-26) (i513825)
### Enhancement - nest merging of environment_values together within null-context
* By default, added behavior to deep merge parent context's `environment_values` with passed `environment_values`
* Can be overridden by existing `reset_environment_values` flag

## Version 3.2.0 (2020-12-26) (i513825)
### Enhancement - ignore_changes to BuildUser
* To prevent "update-in-place" on every resource due to changes to the `BuildUser` tag, unless `ignore_changes` is in use everywhere, changes to `BuildUser` in addition to `ProvisionDate` should be stored as a non-changing value within `null-context`
* This is already accomplished for `ProvisionDate` by using the `time_static` resource type
* Due to a lack of support to store a simple string value as a resource and apply ignore_changes, the `BuildUser` value has been added as a referencable `trigger` value to the `time_static` resource that will only change when the time resource changes (which doesn't change)
* This ensures that per-invocation of `null-context`, both the following values will be cached unchanged for resources that use that context:
    * `ProvisionDate` - initial timestamp of when resource was created
    * `BuildUser` - user ID of the operator that initally created the resource
* This change elimiates the need to use lengthy `ignore_changes` on all resource that use `tags` altogether
* This change is backwards compatible with existing Terraform code, and will not cause any impacting changes
    * In order for changes to take affect, all `time_static` resources across all environments need to be destroyed and re-created

## Version 3.1.6 (2020-12-16) (i513825)
### Bugfix - Bump `label_order` validation check to enforce at least one element
* This is to accommodate "boundary-wide" use cases for `null-context` that are becoming more and more prevalent
* The makes it so the validation checks if there are less than 1 element in the `label_order`, but no longer fails if there is less than two

## Version 3.1.5 (2020-12-14) (c5309336)
### Bugfix - Skip checks for S3 bucket
* Default to skipping checks if s3 bucket flag is set.

## Version 3.1.4 (2020-12-08) (i513825)
### Bugfix - label_order output
* Removed `null` output logic for label_order to prevent errors downstream

## Version 3.1.3 (2020-11-30) (c5309377)
### Bugfix - Logic bug
* Fixed a logic bug in handling label parts

## Version 3.1.2 (2020-11-25) (c5309377)
### Bugfix - Adding local label
* Adding `name_prefix`

## Version 3.1.1 (2020-11-24) (i868402)
### Bugfix - Domain label mapping, Can Bugfix
* Bugfix for Can statement on domain labels

## Version 3.1.0 (2020-11-10) (i513825)
### Enhancement - Domain label mapping
* Dynamically construct and map tiers of domains based on context `label_order`
* e.g. CRE SMS
    * security_boundary = `cre.sapns2.internal`
    * business          = `sms.cre.sapns2.internal`

## Version 3.0.0 (2020-10-19) (i513825)
### Bugfix - AWS account ID check
* Fix conditional logic to properly resolve missing AWS account ID when `skip_checks` is set to `true`

### Bugfix - Outputs
* Added output for `organization`

### Enhancements - skip checks
* Made it so `skip_checks` can be inherited from parent context `environment_values.locals`

### Enhancement - module inputs
* Implemented `partition` input as a part of the standard set of inputs
* Implemented `root_module` input for the name of Terraform environment root module responsible for provisioning resources
* Removed `root_module_version` as this has been renamed to `parent_module_version`
* Implemented `parent_module` input for the name of Terraform parent module responsible for invoking the module
* Implemented `parent_module_version` input for the version of Terraform parent module responsible for invoking the module

### Enhancement - renamed tags
* `Generated-By` - `GeneratedBy` (make consistent with CamelCase used across all other tags)
* `Managed-By` - `ManagedBy` (make consistent with CamelCase used across all other tags)
* `Module` - `TerraformModule` (clarify relation to Terraform specifically)
* `ModuleVersion` - `TerraformModuleVersion` (clarify relation to Terraform specifically)
* `RootModule` - `TerraformRootModule` (clarify relation to Terraform specifically)
* `DeploymentLayer` - `TerraformDeploymentLayer` (clarify relation to Terraform specifically)
* `Workspace` - `TerraformWorkspace` (clarify relation to Terraform specifically)

## Version 2.0.6 (2020-09-17) (c5309336)
### Bugfix - Fix Versions
* Allow Terraform 13

## Version 2.0.5 (2020-09-02) (c5309336)
### Bugfix - Fix tagging errors
* Fix error with unnamed resource tags
* Add output for `bucket` ({ORG}-{NAME}) and `bucket_salted` ({ORG}-{NAME}-{SALT}) (Used for S3 bucket name)

## Version 2.0.4 (2020-08-25) (c5309377)
### Bugfix - Fix tagging errors
* Fix error with tag regex
* Merge default kv into lookup map

## Version 2.0.3 (2020-08-20) (c5309377)
### Bugfix - Fix tagging errors
* Enforce tag regex on all tags
* Add check for resource name length
* Make errors easier to find

## Version 2.0.2 (2020-08-20) (c5309377)
### Bugfix - Fix planning errors
* Reordered locals to fix planning errors
* Add `workspace` default tag

### Enhancement - Tags and Labels
* EC2 only tags are now prefixed with `vm_`
* Remove `product` input
* Add `account_id` and `region` inputs.
* Auto calculate `environment_salt` from `account_id`

## Version 2.0.1 (2020-08-17) (c5309336)
### Enhancement - Refactor
* Major refactor to support many new features
* More dynamic to avoid future changes to inputs of the context module
* Add KV Stores
* Add Dynamic Tagging
* Add feature flags

## Version 0.0.4 (2020-08-06) (c5309377)
### Bugfix - Swapping label
* Swap label order, so that `name_prefix` comes last which matches the documentation.

## Version 0.0.3 (2020-08-04) (c5309336)
### Enhancement - Adding labels
* Add `custom_label` and `name_prefix`

## Version 0.0.2 (2020-07-22) (c5309336)
### Enhancement - Minor Tweaks
* Change label order.
* Add product and `security_boundary` inputs.
* Default customer value to NS2.
* Remove regex filtering on items that dont require filtering.
* Remove `provision_date` from context input and output and use `static_time` module to make more static timestamp.

## Version 0.0.1 (2020-07-21) (c5309336)
### Initial version established for the context module.
* Create context module to create a context object that can be used by resources to determine name, naming prefix, tags.
