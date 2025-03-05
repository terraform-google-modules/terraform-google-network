# Latest Version
2.9-000071

# Version History
## Version 2.9-000071 (2025-01-28) (i537609)
### Enhancement - Added keyname to Apt signing keys
* Added keyname variable to Apt signing keys
* Added module parameter to specify the location of keyring

## Version 2.9-000070 (2024-01-09) (i537609)
### Enhancement - Added cHost application preset selection to list of repositories to enable
* Update latest os version for SLES 15
* Added cHost section under SLES 15 SP2 and SP5 with required repositories
* Updated repositories required for SLES 15 SP2 and SP5 base variant

## Version 2.9-000069 (2025-01-06) (i746373)
### Enhancement - add missing presets
* add missing application presets

## Version 2.9-000068 (2024-11-15) (i558332)
### Enhancement - Add FreeRADIUS repository preset
* Add FreeRADIUS repository preset and key

## Version 2.9-000067 (2024-10-22) (i537609)
### Bugfix - Fix indentation for Ubuntu 22 repositories
* Fix indention for Ubuntu 22 repositories

## Version 2.9-000066 (2024-10-08) (i548447)
### Bugfix - Fix nonexistent_repositories values
* Fix indention for nonexistent_repositories list

## Version 2.9-000065 (2024-10-01) (i548447)
### Enhancement - Updated role to be compatible with RHEL 8.10
* Added RHEL 8.10 nonexistent_repositories
* Added RHEL 9.1 nonexistent_repositories
* Update latest os version for RHEL 8

## Version 2.9-000064 (2024-09-23) (i537609)
### Enhancement - Updated role to be compatible with Ubuntu 22 Jammy
* Added Ubuntu 22 support
* Added Ubuntu 22 repository-disable feature
* Added Ubuntu 22 repository-enable feature
* Added Ubuntu 22 repository-pull feature
* Updated defaults/main.yml to include Ubuntu 22 Jammy repository list and latest_os_version `jammy` is based on Ubuntu 22

## Version 2.9-000063 (2024-03-01) (i568675)
### Enhancement - Add '/etc/scs-release' support to automatic preset selection
* Updated feature that automatically determines the image that the system was created from to alternatively use the `/etc/scs-release` file.

## Version 2.9-000062 (2024-01-04) (i571239)
### Bugfix- Updated 'get-specific-repositories.yml'
* Add SLES 15 task for `set_fact` to ensure that `repository_list` profile is properly selected.

### Bugfix- Removed legacy modules in 'configure-suse.yml' and 'repository-enable.yml'
* Removed the args warn within the command module tasks

### Enhancement- Add gardener-shoot profile for SLES 15
* Add the repositories required by the gardener team for SLES 15.

## Version 2.9-000061 (2023-12-07) (c5357274)
### Bugfix- Updated 'get-specific-repositories.yml'
* The conditional check had a syntax error that had to be updated.

## Version 2.9-000060 (2023-04-26) (c5357274)
### Enhancement - Updated 'latest_os_versions' from RHEL 8.7 to 8.8
* Updated the latest RHEL version to 8.8 so the latest repo file to be downloaded.

## Version 2.9-000059 (2023-03-31) (i568675)
### Enhancement - Increase compatibility with SLES 15
* Updated the repository list for SLES 12 & SLES 15 to be split by service pack
* Updated get-specific-repositories logic to support nested dicts from the repository list
* Updated SLES repository-disable to use `zypper modifyrepo`
* Updated SLES repository-enable to use `zypper modifyrepo`
* Updated SLES repository-pull to reflect changes made to `repository-synchronization-zypper` role

## Version 2.9-000058 (2023-02-07) (i513825)
### Bugfix - ReleaseLock Delegation
* Local delegation errors out in Concourse with `\n` newline at the end of the `delegate_to:` attribute

## Version 2.9-000057 (2023-02-01) (i513825)
### Bugfix - ReleaseLock Conditional
* Update conditional logic wrapped around the ReleaseLock feature to properly skip by default
* Problem was `repo_release_lock` was defined in `defaults/main.yml` but left as `none`

## Version 2.9-000056 (2023-01-25) (i513825)
### Feature - ReleaseLock
* Add support to optionally pull OS minor-version to install package repositories for from `ReleaseLock` EC2 tag
* Optionally can opt to have old package repositories removed during this process

## Version 2.9-000055 (2022-12-09) (i537609)
### Enhancement - Updated 'latest_os_versions' for RHEL 8.6 to 8.7
* Updated the latest RHEL version to 8.7 so the latest repo file to be downloaded.

## Version 2.9-000054 (2022-12-06) (i513825)
### Bugfix - Module `warn` argument deprecation
* Remove usage of deprecated `warn: false` argument on shell and command modules
* Without removing them causes failures in our Concourse pipelines that currently run the latest version of Ansible in the worker containers

## Version 2.9-000053 (2022-11-18) (i537609)
### Bugfix - Added Ubuntu 18.04 back to latest_os_versions dict
* Added Ubuntu 18.04 back to the `latest_os_versions` dictionary in `defaults/main.yml`

## Version 2.9-000052 (2022-11-08) (c5323009)
### Enhancement - Added ubuntu 20.04 entries to repo_dns_list
* Added new package repositories to the repo_dns_list in `repository-management/defaults/main.yml`

## Version 2.9-000051 (2022-09-14) (i571239)
### Enhancement - Updated role to be compatible with SLES 15
* Added Zypper support
* Added SLES repository-disable feature
* Added SLES repository-enable feature
* Added SLES repository-pull feature
* Added SLES configuration support for repo delete and force
* Updated defaults/main.yml to include SLES 15 repository_list, base, and latest_os_version. 15.2 is based on SLES 15 SP2

## Version 2.9-000050 (2022-07-15) (i537609)
### Bugfix - Removed invalid Azure repository for Ubuntu
* Removed the `azure-cli` repo from Ubuntu defaults to avoid error with improperly mirrored repository

## Version 2.9-000049 (2022-05-24) (c5323009)
### Enhancement - Updated 'latest_os_versions' for RHEL 8.5 to 8.6
* Updated RHEL latest OS version to allow for the latest repo file to be downloaded.

## Version 2.9-000048 (2022-05-10) (c5332214)
### Bugfix - Updated the Azure CLI repository for RHEL 8
* Updated RHEL 8 azure cli repository to be packages-microsoft-com-prod
* Note that the pre-existing azure-cli repository is not maintained for RHEL 8

## Version 2.9-000047 (2022-05-06) (i869415)
### Enhancement - Added 'gardener-shoot' preset
* Added a new application preset selection for 'gardener-shoot'.

## Version 2.9-000046 (2022-04-05) (i537609)
### Enhancement - Added additional non-existent repositories for RHEL 8.3 and 8.5
* Added repositories that do not exist for RHEL 8.3 and 8.5 which causes errors when enabled

## Version 2.9-000045 (2022-02-15) (i869415)
### Enhancement - Adding new us-west-2 repository S3 bucket
* Added the new us-west-2 repository S3 bucket to the repofile DNS list variable.

## Version 2.9-000044 (2022-02-01) (i537609)
### Enhancement - Added Azure preset selection and new signing key
* Added new Azure preset selection which includes the azure-cli package
* Added the Microsoft public signing key

## Version 2.9-000043 (2021-12-13) (c5323009)
### Enhancement - Updated 'latest_os_versions' for RHEL 8.4 to 8.5
* Updated RHEL latest OS version to allow for the latest repo file to be downloaded.

## Version 2.9-000042 (2021-10-21) (i869415)
### Enhancement - Added new 'repo_latest' variable
* Added the new 'repo_latest' variable to allow for the latest repo file to be downloaded.
* Added a new Molecule test scenario 'docker-enable-latest-base-repositories' to test the new variable.

## Version 2.9-000041 (2021-10-21) (i869415)
### Enhancement - Added e4s repositories
* Added new 'e4s' repositories for RHEL 7.
* Added a new Molecule test scenario that tests enabling all repositories for the given OS.

## Version 2.9-000040 (2021-10-20) (i544961)
### Documentation - Add verbiage pertaining specifically to RHEL 8.4 support
* Updated README to include verbiage regarding RHEL 8.4 support

## Version 2.9-000039 (2021-09-14) (c5323009)
### Enhancement - Add an 'all' preset for Ubuntu 18.04, amazon_2018 and amazon2
* Add an 'all' preset to the repository-management role defaults for Ubuntu 18, amazon_2018 and amazon2
* Added 8.3 and 8.4 to nonexistent-repositories

## Version 2.9-000038 (2021-08-20) (i869415)
### Enhancement - Added OpenVPN preset for Ubuntu 18.04
* Added the 'openvpn' preset for Ubuntu 18.04.

## Version 2.9-000037 (2021-08-16) (i869415)
### Enhancement - Added additional stopgap for missing repos errors
* Added an additional stopgap to the role so that it will not attempt to enable repositories that do not exist for the given OS.

## Version 2.9-000036 (2021-07-27) (c5323009)
### Bugfix - Added kubernetes to repository list for ubuntu-18
* Added kubernetes to ubuntu-18 repository list in support of kubernetes image variant

## Version 2.9-000035 (2021-06-25) (i869415)
### Bugfix - Fixed issues with nonexistent yum repositories
* Fixed an issue where yum would throw errors if a specific repository did not exist for the given operating system.
* Added a task file to run post-configuration tasks and disable any repositories that do not exist for the given operating system.

## Version 2.9-000034 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000033 (2021-03-31) (i869415)
### Enhancement - Added 'ca-central-1' repository S3 bucket
* Added the new 'ca-central-1' repository S3 bucket to the list of available S3 buckets.

## Version 2.9-000032 (2021-03-05) (i869415)
### Bugfix - Added missing Docker preset for Ubuntu 18.04
* Added the 'docker' preset to the Ubuntu 18.04 repository list.

## Version 2.9-000031 (2021-03-05) (i869415)
### Enhancement - Ensure repo file directories are present
* Added tasks to ensure that the repository file directories such as '/etc/yum.repos.d' are present.

## Version 2.9-000030 (2021-03-05) (i869415)
### Bugfix - Fixed bug when pulling repo file
* Modified role to always download a repo file if it is able to connect to it.
* Fixed bug where Ansible would not download the repository file if it's already present in some cases.
* Fixed bug where duplicate entries of the same URL would be saved as the domain that was used to download the repo file.

## Version 2.9-000029 (2021-02-26) (i869415)
### Bugfix - Replaced 'selectattr()' Jinja2 filter usage
* Removed the use of the 'selectattr()' Jinja2 filter and replaced with a 'set_fact' Ansible task.
* The comparison operators that the 'selectattr()' filter tests use were not added until version '2.10' of the 'python-jinja2' package.
  * The latest available version of the 'python-jinja2' package on RHEL 7 is '2.7.2'.

## Version 2.9-000028 (2021-02-25) (i869415)
### Bugfix - Properly convert the 'application_preset_selection' variable
* Fixed a conditional so that the role properly detects whether the provided 'application_preset_selection' variable is actually a string or not.
* Edge cases where the 'application_preset_selection' variable was provided via extra-vars as a JSON unicode type variable would result in unexpected results.
* Fixed an edge case where if the 'application_preset_selection' variable was provided as an empty, null, or none value, then the role would fail.

## Version 2.9-000027 (2021-02-24) (i869415)
### Bugfix - Added missing Ubuntu signing keys
* Added a task to enable the necessary Ubuntu Apt signing keys on Debian-based systems.

## Version 2.9-000026 (2021-02-08) (i869415)
### Feature - Role refactor
* Refactored the 'repository-management' Ansible role.
* Added Ubuntu 18.04/apt support.
* Added preliminary Amazon Linux 1/2 support.
* Restructured the role to support multiple operating systems.
* Added task files for configuring the system before enabling/disabling repositories.
* Refactored use of the 'automatic_preset_selection' variable.
* Added the ability to provide multiple values to the 'application_preset_selection' variable.
* Deprecated use of the following variables.
  * 'redhat_repo'
  * 'epel_repo'
  * 'repo_delete_all'
  * 'repo_setup'

## Version 2.9-000025 (2020-11-24) (i869415)
### Enhancement - Added missing RHEL 8 presets
* Added missing application_preset_selection presets for RHEL 8.

### Bugfix - Fixed idempotency issue
* Fixed an issue where the repository file was always pulled down.
* Fixed an issue where the currently enabled repositories are wiped out when a new copy of the repository file is pulled down.

## Version 2.9-000024 (2020-10-27) (i839460)
### Enhancement - Changed repo file name to more shortened, friendly verison
* Enhancement - Changed repo file name to more shortened, friendly verison

## Version 2.9-000023 (2020-09-24) (i839460)
### Enhancement - Made yum not stop on 404 errors
* Added skip_if_unavailable=True to yum and dnf.conf to prevent yum stopping the run on any 404'd repositories

## Version 2.9-000022 (2020-09-21) (i839460)
### Enhancement - Adding Ansible repositories to RHEL 8 and RHEL 7
* Added rhel-7-server-ansible-2-rpms for rhel7 to all varants
* Addded ansible-2-for-rhel-8-x86_64-rpms for rhel8 to all variants

## Version 2.9-000021 (2020-09-04) (i839460)
### Enhancement - Adding High Availability repositories to RHEL 8 sap preset
* Added highavailability repositories to the RHEL 8 sap preset.
* Added functionality to enable/disable repositories on one line to speed up execution
* Added gate to not download a repofile if it already exists unless redhat_repo=true
* Added hana preset selection to RHEL8 (matching sap)

## Version 2.9-000020 (2020-08-24) (i869415)
### Enhancement - Adding EUS repositories to RHEL 7 presets
* Added EUS repositories to the RHEL 7 presets.

## Version 2.9-000019 (2020-08-19) (i839460)
### Enhancement - Added base repositories to azure preset
* Added base repositories to azure preset

## Version 2.9-000018 (2020-07-28) (i839460)
### Enhancement - changed subscription-manager config setting to explicit file search-replace
* subscription-manager config line was not correctly eliminating yum warning on rhel8.0

## Version 2.9-000017 (2020-07-27) (i839460)
### Bugfix - Added baseos repositories to epel preset selections
* Expected run of `redhat_repo: true` and `epel_repo: true` didn't include baseos+epel repos

## Version 2.9-000016 (2020-07-23) (i839460)
### Enhancement - Corrected rhel8 repositories for application preset base, docker
* Removed e4s (SAP Update servies) from base application preset
* Corrected e4s repositories in docker application preset to eus (extended update support)
* Added supplemental repositories to docker and sap presets to match base

## Version 2.9-000015 (2020-07-22) (i839460)
### Enhancement - Added additional SAP netweaver repositories
* Added netweaver repositories to sap and all presets for access to the `sapconf` rpm
* Added EUS (extended update support) to select rhel8 repositories (see https://access.redhat.com/support/policy/updates/errata/#Extended_Update_Support for timelines and support)
* Moved EUS repositories to default to apply to all rhel7 minor versions not just 7.7
* Added supplementary rpms repository to base to match rhel7 offerings of extras by default

## Version 2.9-000014 (2020-07-20) (i839460)
### Bugfix - Added ignore_errors to repository enable loop
* Some repositories listed don't exist in all minor versions; added stopgap until role refactor

## Version 2.9-000013 (2020-07-17) (i839460)
### Bugfix - become: true and have rhsm not manage repositories
* Modified the `when` change to add more flexibility
* Added task to make subscription-manager (rhsm) not manage repositories

## Version 2.9-000012 (2020-07-16) (i861009)
### Bugfix - Flawed ansible success test causes failure
* Fixed a flawed `when` test that would cause failures when the task succeeded.

## Version 2.9-000011 (2020-07-14) (i839460)
### Enhancement - Support for RHEL8, new repository format
* Added support for rhel8 with preset selections (all, base, sap, epel)
* Changed repo download logic to support new repository format and locations
* Added logic to remove depreciated build-redhat.repo and build-epel.repo files

## Version 2.9-000010 (2020-07-08) (i513825)
### Bugfix - Added `rhel-7-server-eus-rpms` to RHEL 7 SAP repolist
* Added `rhel-7-server-eus-rpms` to RHEL 7 SAP repolist to fix SSM patching issue #263

## Version 2.9-000009 (2020-05-29) (i869415)
### Enhancement - Added preset for ns2labs
* Added 'ns2labs' appplication preset.
* Added for clarity in the naming of presets for NS2 Labs and Qualtrics automation.

## Version 2.9-000008 (2020-05-28) (i870123)
### Enhancement - Added preset that includes the RHEL 7 optional repo
* Added 'qualtrics' appplication preset that includes the RHEL 7 optional repository.

## Version 2.9-000007 (2020-03-23) (i869415)
### Bugfix - Fixed bug with defaults
* Fixed a bug where if 'application_preset_selection' was not defined, the role would fail.

## Version 2.9-000006 (2020-03-16) (i869415)
### Enhancement - S3 region and image name detection
* Added tasks to automatically select the AWS region's S3 bucket to pull from.
* Updated feature that automatically determines the image that the system was created from to use the `/etc/ns2-release` file.
* Removed unnecessary files like handlers and vars.
* Updated documentation with current terminology, such as the use of `image` instead of `AMI`.

## Version 2.8-000005 (2020-01-08) (i516349)
### Enhancement - Normalized repo filename
* Removed red hat major relase version from filename
* Prepended `build-` to both redhat and epel repo files

## Version 2.8-000004 (2019-11-07) (i869415)
### Enhancement - Added kubernetes image variant
* Added kubernetes image variant to defaults.

## Version 2.8-000003 (2019-08-20) (i869415)
### Enhancement - Refactor code and add EPEL support
* Role has been refactored to solve multiple problems and run better.
* Added new variables for greater control over how the role runs.
* Added support for EPEL.

## Version 2.8-000002 (2019-08-19) (i869415)
### Enhancement - Refactor code and add EPEL support
* Role has been refactored to solve multiple problems and run better.
* Added new variables for greater control over how the role runs.
* Added support for EPEL.

## Version 2.8-000001 (2019-08-05) (i869415)
### Initial version established with the following features
* Uploaded role to gitlab
* Can pull the repository file from S3 and enable certain repositories based on the AMI name or a specific list
* Can disable repositories based on the AMI name or a specific list
* Can remove all repository files from the system
