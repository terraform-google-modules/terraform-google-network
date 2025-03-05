collectd
========

This role is used to configure Collectd configuration based on the application type supplied.

Requirements
------------

* Anisble 2.9+
* Public internet connection to the runner's machine. This is required for pulling the latest AWSLabs collectd-cloudwatch code from the git repository.

Role Variables
--------------

* cloudwatch_integrate: This is a boolean for whether to integrate Collectd with Cloudwatch.
* collectd_cloudwatch_plugins_directory: Directory for storing the collectd-cloudwatch integration files. These are supplied by AWS and pulled via git.
* collectd_cloudwatch_whitelist_pass_through: Defaults to `false`, as enabling this may result in a significant number of metrics being supplied to Cloudwatch. This allows unsafe regex searches such as `.*` and `.+`.
* collectd_cloudwatch_debug: Boolen for whether to enable collectd and cloudwatch debugging. Defaults to `false`.
* aws_region: Defaults to `us-gov-west-1`.
* application_preset_selection: Sets the application customization used for configuring the Collectd monitoring. Defaults to `default`.
* ports_cpids: Sets the monitoring ports for a CPIDS instance.
* ports_default: Sets the default monitoring port to `22`.
* ports_hana: Sets the monitoring ports for a HANA instance
* ports_openvpn: Sets the monitoring ports for an OpenVPN instance.
* ports_sap: Sets the monitoring ports for a SAP Application instance.
* ports_webdispatcher: Sets the monitoring ports for a WebDispatcher instance.

Dependencies
------------

* Access to the AWS Git repo from the user's workstation

Example Playbooks
----------------

The following will perform the default functionality of installing/configuring collectd. It will prompt the user for which Collectd configuration to apply.

```
- hosts: all
  vars_prompt:
    - name: application_preset_selection
      prompt: "Select an option for Collectd plugin configuration (cpids,default,hana,sapapp,openvpn,webdispatcher)"
      private: no

  tasks:
    - name: 'Install Cloudwatch plugin'
      include_role:
        name: ../../code/ansible-roles/roles/collectd
```

The following will do the same as above, but configure Collectd for a CPIDS instance.
```
- hosts: all
  tasks:
    - name: 'Install Cloudwatch plugin'
      include_role:
        name: ../../code/ansible-roles/roles/collectd
      vars:
        cw_preset_selection: cpids
```

License
-------

BSD

Author Information
------------------

Richard Breiten (c5295459) richard.breiten@sapns2.com
