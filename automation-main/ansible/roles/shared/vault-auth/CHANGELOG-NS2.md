# Latest Version
2.9-000022

# Version History
## Version 2.9-000022 (2024-11-07) (i744693)
### Bugfix - Mark upload_secrets as no_log
* add variable to control no_log of upload secrets

## Version 2.9-000021 (2024-01-23) (i548472)
### Enhancement - Add ability to upload secrets to vault
* Add ability to upload secrets to vault
* Updated README
* Update `defaults/main.yml``


## Version 2.9-000020 (2023-04-18) (i561481)
### Bugfix - Remove hyphens from retrieved_credentials keys
* Adds a replace filter to the keys for `vault_retrieved_credentials` output to remove hyphens and replace with underscores
* Updated README

## Version 2.9-000019 (2023-03-10) (i561481)
### Enhancement - Adds AWS, GCP, and Azure Secrets Engine Support
* Adds retrieve credentials tasks to `main.yml`
* Adds `retrieve-credentials.yml` files within each provider tasks directory
* Adds `vault_secrets_type` default variable to select secrets engine provider
* Adds default variables to select secrets engine name

## Version 2.9-000018 (2023-02-07) (i561481)
### Enhancement - Added GCP Auth Method Support
* Refactored `retrieve-token` conditionals in `tasks/main.yml`
* Added `tasks/gcp/retrieve-token.yml` to support GCP Authentication
* Added GCP default variables to `defaults/main.yml`
* Added `templates/vault-gcp-jwt-claim.json.j2`
* Added GCP variables to README

## Version 2.9-000017 (2023-01-30) (i561481)
### Enhancement - Added Azure Auth Method support
* Separated Azure and AWS authentication into separate directories
* Added `tasks/azure/retrieve-token.yml` to support Azure Authentication
* Added Azure default variables to `defaults/main.yml`
* Added new Azure variables to README

## Version 2.9-000016 (2022-05-09) (i870146)
### Enhancement - Added variable to replace ansible_ec2_placement_region
* Added `replace_ansible_ec2_placement_region` to set the `ansible_ec2_placement_region` if ec2_metadata_facts ansible_ec2_placement_region is different from the aws_account_region.

## Version 2.9-000015 (2022-07-14) (i869415)
### Bugfix - Fixed a bug for pulling an entire secret's JSON
* Fixed a bug when attempting to save an entire secret's JSON as an Ansible fact.

## Version 2.9-000014 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000013 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000012 (2021-04-07) (i513825)
### Bugfix - fix delegate_to omission logic
* Fix logic to fully omit `delegate_to` directive when configured to execute tasks on target host machines

## Version 2.9-000011 (2021-03-31) (i513825)
### Enhancement - construct ansible lists/dictionaries with retrieved secrets
* Added optional capability to append retrieved secrets values to new or existing ansible list/dictionary variables
* Improved functionality of test playbook within role to be able to delegate to local machine or run on remote machine

## Version 2.9-000010 (2020-11-16) (i861009)
### Bugfix - SSL verification
* fixed logic around how `vault-auth` role performs SSL verification when using EC2 instance profile authentication

## Version 2.9-000009 (2020-09-04) (i861009)
### Enhancement - Removed relative paths
* Removed relative path for include_role task

## Version 2.9-000008 (2020-06-16) (i869415)
### Bugfix - Use 'include_tasks' in main.yml
* Replaced use of 'include' tasks in main.yml with 'include_tasks'.
* Running into issues with how the 'include' task works.

## Version 2.9-000007 (2020-06-01) (i511522)
### Enhancement - Update ec2_instance_facts to ec2_instance_info
* Changed ec2_instance_facts to ec2_instance_info

## Version 2.9-000006 (2020-05-14) (i513825)
### Bugfix - regex expression escape character
* Removed backslash escape character from regex expression as it was causing syntax problems in slightly older versions of ansible

### Bugfix - engine version query failure fix
* Instead of bombing out when the user does not have access to read the engine/config path to see if the secrets engine is a v1 or v2 engine, default to attempt to read secrets using v1 URI

### Enhancement - force v2 formatting
* Added ability to allow passing of `secret_version` set to `latest` to force v2 URI formatting

### Enhancement - non-sensitive error reporting amidst `no_log`
* Added dedicated error reporting catch that conveys to the user useful messages if errors occur that do not contain any sensitive information since most other tasks are protected by `no_log: yes`

## Version 2.9-000005 (2020-05-12) (i513825)
### Enhancement - Added support for different engine types
* Added functionality and documentation on pulling from a versioned (v2) key vault engine
* Added functionality and documentation on pulling versioned secrets

## Version 2.9-000004 (2020-04-28) (i511522)
### Enhancement - Update secrets retrieval.
* Updated role to better retrieve secrets from Vault.
* Updated the default variables to reflect changes to secret retrieval.

## Version 2.8-000003 (i511522)
### Bugfix - token retrieval
* Fixed all issues regarding EC2 auth token retrieval

## Version 2.8-000002 (i516349)
### Bugfix - fixing default hard coded legacy values
* Updating default hard coded iam role from `dev` to `build-default`

## Version 2.8-000001 (i516349)
### Enhancement - parameterizing ssl validation
* Adding variable `vault_skip_verify` to enable toggling of ssl validation for vault's with self signed certificates

## Version 2.7-000004 (i516349)
### Enhancement - fully-qualified domain name
* Updated default vault uri to point to external domain name

## Version 2.7-000003 (c5283382)
### Enhancement - full secret retrieval
* Added a task to retrieve entire hashicorp vault secret and return it in the dictionary vault_retrieved_secrets

## Version 2.7-000002 (i868402)
### Bugfix - secret retrieval
* Fixed problem with Dictionary query

### Enhancement - multi-secret retrieval
* Modified logic to handle multiple secret lookup
* Now passes back a collection of all secrets retrieved

## Version 2.7-000001 (c5283382)
### Initial version established with the following features
* Retrieves vault authentication token
* Retrieves single secret key/value pair based off of value
