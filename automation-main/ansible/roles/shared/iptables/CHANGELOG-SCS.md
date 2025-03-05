# Latest Version
2.9-000035

# Version History
## Version 2.9-000035 (2025-02-04) (i746373)
### Bugfix for ubuntu 22 host
* add iptables wait for rules

## Version 2.9-000034 (2023-05-30) (i746373)
### Bugfix unable to save iptable rules on ubuntu-18 hosts
* remove the base64decode from the save rules tasks

## Version 2.9-000033 (2023-02-14) (c5337154)
### Enhancement - Added application variants for Tenable products
* Added the following application_variants to defaults/main.yml:
  * security_center
  * nessus_manager

## Version 2.9-000032 (2023-11-30) (i513825)
### Bugfix - Save Rules
* Fix iptables rule persistence logic by ensuring:
  * missing `COMMIT` line is present
  * missing `:ANSIBLE_MANAGED - [0:0]`
  * missing `-A INPUT -j ANSIBLE_MANAGED` line is present

## Version 2.9-000031 (2023-11-17) (c5343286)
### Enhancement - Add support for iptables wait
* Add support for iptables lock wait

## Version 2.9-000030 (2023-11-14) (i548219)
### Enhancement - Add bobj_bip to iptables default main
* Add configuration for bobj_bip to iptables
* Added port requirements for bobj_bip to defatault/main.yml

## Version 2.9-000029 (2023-04-27) (i571239)
### Enhancement - Add Suse 15 support
* Add configuration for iptables on Suse 15
* Add mitigation for masking firewalld on Suse 15
* Format Suse distribution to use 12 and 15 separately

### Enhancement - Additional checks for missing files
* Add checks to make sure file exists at /etc/sysconfig/iptables
  * Without this, the role fails as it cannot perform `lineinfile` during setup

## Version 2.9-000028 (2022-12-06) (i513825)
### Enhancement - Default FORWARD chain override
* Adds `iptables_default_forward_chain_behavior` variable for user to optionall override default FORWARD chain behavior

### Enhancement - Concourse firewall preset
* Add `firewall_preset_selection` for Concourse

## Version 2.9-000027 (2022-11-15) (i513825)
### Bugfix - Persistent Iptables Rule Idempotency
* Ensure installation/setup of ANSIBLE_MANAGED rules only parses ansible-managed rules for persistence
  * Avoids problem where Container Network Interface iptables rules for containers were being persisted during subsequent `iptables` role executions
* Ensure removal of ANSIBLE_MANAGED rules only parses ansible-managed rules for removing their persistence

### Enhancement - Flush Rules Idempotency
* Deprecate `iptables_flush_chain` input
* Leverage second iptables chain to construct a new chain every time and drop it in place
  * Ensures removals/additions are captured every time without need to flush chain and cause a possible blip in connectivity

### Enhancement - Optional default behavior overrides
* Adds `iptables_default_input_chain_behavior` to possibly override default log + `RETURN` behavior to log + `DROP`
* Adds `iptables_default_ansible_managed_chain_behavior` to possibly override default ACCEPT behavior for a preset list of ports and simply `RETURN` for other rules to process

### Enhancement - Code Organization and Cosmetic Refactoring
* Leverage shared taskfiles to reduce large amount of copy+pasted logic having to be maintained
* Break exceedingly long single-line conditionals into multiple lines
* Leverage `block:` statements to reduce leveraging same conditional numerous times on large numbers of adjacent tasks
* Touch up old comments not relevant to the file they were copied into or bits that reference logic that has since been removed
* Touch up README documentation

### Bugfix - Firewall Preset via AWS Instance Tags
* Fix broken block logic preventing code from never firing
* Apply default preset behavior if tag `ProductName` does not match explicit application_variant instead of failing
* Variablized `task_delegation`

### Bugfix - SUSE service restart itempotency
* Do not restart SUSE firewall service on every execution
* Only restart when changes detected to firewall configuration that need to get picked up

## Version 2.9-000026 (2022-10-27) (i548472)
### Enhancement - Adding inventory
* Added inventory directory to pass different variables depending on host

## Version 2.9-000025 (2022-05-09) (i869415)
### Enhancement - Adding Gardener preset
* Added a preset for 'gardener-shoot' to the list of firewall preset selections.

## Version 2.9-000024 (2022-02-17) (c5309377)
### Enhancement - Remove logrotate stuff
* logrotate and configuring logrotate for system logs does not belong in this role

## Version 2.9-000023 (2022-02-02) (i537609)
### Enhancement - Added 'sapiq' preset
* Added the 'sapiq' preset that contains a list of the expected ports for SAP IQ.

## Version 2.9-000022 (2022-01-24) (i869415)
### Enhancement - Added 'default_gardener' preset
* Added the 'default_gardener' preset that contains a list of the expected ports for a Gardener system.

## Version 2.9-000021 (2022-01-18) (c5323009)
### Bugfix - Updated galaxy_info variables missing breaking molecule test runner
* Added role_name and namespace variables if missing broke molecule test runner

## Version 2.9-000020 (2021-05-05) (c5323009)
### Bugfix - Updated ns2-scp-dev.sapns2.us domain to gitlab.core.sapns2.us
* Updated issue_tracker_url variable using old gitlab domain to new core services domain

## Version 2.9-000019 (2021-04-30) (i869415)
### Enhancement - Disabled and masked UFW on Ubuntu
* Added a task to disable and mask UFW on Ubuntu instances, just as we do with firewalld on RHEL instances.

## Version 2.9-000018 (2021-03-09) (i513825)
### Bugfix - revert find-executable-path changes
* revert find-executable-path changes

## Version 2.9-000017 (2021-03-08) (i513825)
### Bugfix - dynamically find iptables executable
* Fixes systems where default installation location for `iptables` is not found on PATH
* In this case, will perform dynamic search for `iptables` executable

## Version 2.9-000016 (2021-03-08) (i513825)
### Bugfix - continue with install when command not found
* Permit continuation of installation when `iptables` command not found

## Version 2.9-000015 (2021-02-26) (i868402)
### Enhancement - additional ports for S4PCE
* Add ports used by bobj (Business Objects)
* Add ports used by data_services
* Add ports used by information_steward
* Add ports used by lumira
* Add ports used by sapapp_abap
* Add ports used by sapapp_java

## Version 2.9-000014 (2020-12-15) (c5309377)
### Bugfix - Add mail relay ports
* Add ports used by the Postfix mail relay

## Version 2.9-000013 (2020-12-01) (i513825)
### Bugfix - add Consul communication port to Vault variant
* Add port `8500` to HashiCorp Vault application variant for backend Consul communication

## Version 2.9-000012 (2020-12-01) (i513825)
### Enhancement - add application variant for HashiCorp Vault
* Add application variant for HashiCorp Vault to allow traffic to Vault UI on port `8200`

## Version 2.9-000011 (2020-11-04) (i826342)
### Enhancement - prevent spam/overload of log files
* Log only NEW connections and limit logs to avoid overload of log files and splunk.

## Version 2.9-000010 (2020-08-30) (i536519)
### Bugfix - fix logrotate for debian
* Updated bash script that handles the restarting of the rsyslog service (Switch invoke-rc.d to systemctl kill -s HUP rsyslog service)

## Version 2.9-000009 (2020-07-30) (i514383)
### Enhancement - Removes default values related to the deprecated AWX role
* Removes default values related to the deprecated AWX role from the defaults/main.yml file.

## Version 2.9-000008 (2020-05-29) (i826342)
### Bugfix - ignore lo and DNS traffic
* Add rules to ignore all loopback traffic, and prevent dns from spamming the logs.
* Add Nessus agent port to SAC standard list

## Version 2.9-000007 (2020-05-07) (i869415)
### Enhancement - Added support for Debian systems (Ubuntu)
* Added task files for installing, removing, and configuring iptables on Debian systems (Ubuntu falls under this).

## Version 2.9-000006 (2020-04-27) (i511522)
### Enhancement - Dynamic application detection
* Added ability to determine firewall preset selection from files located on the system or the ProductName instance tag.

### Enhancement - Dynamic iptables rules based on netstat
* Added dynamic iptables rules based on netstat output

## Version 2.9-000005 (2020-03-25) (i868402)
### Bugfix - eth0 undefined
* Replaced ansible_eth0.ipv4.address with ansible_default_ipv4.address
* See https://github.com/gregswift/ansible-ipaserver/issues/6

## Version 2.9-000004 (2020-03-18) (i869415)
### Enhancement - SUSE Linux and SAC support
* Added a default firewall_preset_selection for SAC.
* Added support for SUSE Linux.
* Re-organized role to easily support new OS types.

## version 2.9-000003 (2020-01-10) (i868402)
### Enhancement - Webdispatcher ports
* Add ports to webdispatcher preset to cover expected inputs 44301:44303

## Version 2.9-000002 (2020-01-02) (i869415)
### Bugfix - Rename application_preset_selection
* Renamed application_preset_selection to firewall_preset_selection to avoid variable collision.

## Version 2.9-000001 (2019-11-14) (i869415)
### Initial version established with the following features
* Installs the iptables-services package and service.
* List of port numbers selected via the 'firewall_preset_selection' variable.
* Creates iptables rules based on the provided ports to log all packets except those containing the provided ports.
* Can remove the iptables-services package and service from the system and clear all iptables rules.
* Can dynamically determine certain port numbers based on the SAP application's instance number if present.
