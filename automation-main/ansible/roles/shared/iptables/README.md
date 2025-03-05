iptables
========

Installs iptables packages and services for persistent use of iptables as system firewall.

Then creates iptables rules based on the provided port numbers, and by default logs all packets that do not contain the provided port numbers. Will stop and mask vendor-provided firewalls (e.g. `ufw` or `firewalld`)

Requirements
------------

* Ansible 2.9+
* Enabled repositories for downloading iptables packages depending on the distribution
  * e.g. `iptables` (all), `iptables-persistent` (debian), `iptables-services` (redhat)

Role Variables
--------------

| Variable Name                                   | Type           | Default Value                                                                                                              | Description                                                                                                                      |
|-------------------------------------------------|----------------|----------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| firewall_preset_selection                       | string         | default                                                                                                                    | The type of system to setup iptables rules for. Must be one of the items listed in the 'application_variants' default variable   |
| dynamic_preset_selection                        | bool           | false                                                                                                                      | Whether or not to dynamically determine the application type                                                                     |
| iptables_use_instance_tags                      | bool           | Whether or not to configure iptables rules based on application variant specified by the 'ProductName' tag of the instance |
| task_delegation                                 | string         | localhost                                                                                                                  | The host to delegate the tasks to that interact with the cloud providers                                                         |
| iptables_configure_rules                        | bool           | Whether or not to configure iptables with rules. Setting this to false will only install the iptables package and service  |
| iptables_remove                                 | bool           | false                                                                                                                      | Whether or not to remove the iptables package and service from the system                                                        |
| iptables_lock_wait                              | string         | 4                                                                                                                          | Iptables lock wait                                                                                                               |
| iptables_log_limit                              | string         | 12/min                                                                                                                     | Amount of packets to log in the format x/period, e.g.: 1/sec                                                                     |
| iptables_log_limit_burst                        | string         | 5                                                                                                                          | Amount of packets to log before the limit defined in the 'iptables_log_limit' is enforced for the duration of the limit interval |
| iptables_default_input_chain_behavior           | sting          | ACCEPT                                                                                                                     | Default INPUT chain behavior, e.g. ACCEPT, DROP                                                                                  |
| iptables_default_forward_chain_behavior         | sting          | ACCEPT                                                                                                                     | Default FORWARD chain behavior, e.g. ACCEPT, DROP                                                                                |
| iptables_default_ansible_managed_chain_behavior | string         | ACCEPT                                                                                                                     | Default ANSIBLE_MANAGED chain behavior, e.g. ACCEPT, RETURN                                                                      |
| application_variants                            | dict(<object>) | List of ports for each instance type, see `defaults/main.yml` for more details                                             |

Dependencies
------------

* Requires that the `rhel-7-server-rpms` repository be enabled so that the `iptables-services` package can be installed.

Notes
-----

Port numbers defined under the `application_variants` default variable can have the strings `nn` or `nx` in them (For example, destination port number `4nn06` or `3nx07`). The string `nn` is automatically replaced with the SAP application's instance number if it is present (Found at: `/usr/sap/<SID>/[DVEBMGS|HDB|W]<NN>`). The string `nx` is automatically replaced with the instance number incremented by 1. This rule is explained in the following SAP documentation in the 'Rule' column: https://help.sap.com/viewer/ports

Example Playbooks
-----------------

1. The following playbook will install the iptables package(s), service(s), and configure iptables rules. The iptables rules will log all packets that do not have a source or destination port of `22`:
    ```
    - hosts: all

      vars:
        firewall_preset_selection: default
        iptables_configure_rules: true
        application_variants:
          default:
            tcp:
              src:
                - 22
              dest:
                - 22
            udp:
              src: []
              dest: []

      tasks:

      - name: Call the iptables role
        include_role:
          name: iptables
    ```

1. The following playbook will install the iptables package(s), service(s), and configure iptables rules. The iptables rules will both log then drop all packets that do not have a source or destination port of `22`:
    ```
    - hosts: all

      vars:
        firewall_preset_selection: default
        iptables_configure_rules: true
        iptables_default_input_chain_behavior: DROP
        application_variants:
          default:
            tcp:
              src:
                - 22
              dest:
                - 22
            udp:
              src: []
              dest: []

      tasks:

      - name: Call the iptables role
        include_role:
          name: iptables
    ```

License
-------

BSD

Author Information
------------------

* Matt Bittner (i869415) matthew.bittner@sapns2.com
* Devon Thyne (i513825) devon.thyne@sapns2.com
