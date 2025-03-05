ClamAV
======

Installs ClamAV, either as a script or a daemon, sets up a cron job, and runs a scan.

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Anisble 2.9+
* EPEL repository
* Minimum hardware requirements of 1 GB of RAM and 2 CPU e.g., AWS t3.micro Instance Type

Role Variables
--------------

| Variable Name                       | Type   | Default Value   | Description |
| -------------                       | ----   | --------------- | ----------- |
| clamav_run_scan                     | bool   | false           | Whether to run a ClamAV scan. |
| clamav_create_cron_schedule         | bool   | false           | Whether to setup a cron job to run ClamAV scans. |
| clamav_remove_cron_schedule         | bool   | false           | Whether to remove the ClamAV cron job. |
| clamav_targeted_scan_script         | bool   | false           | Whether to setup additional script that can use used to perform ClamAV scans on-demand against a target path on the filesystem |
| clamav_initialize_database          | bool   | false           | Whether to initialize ClamAV database on-demand as a parf of role configuration |
| clamav_schedule_database_refresh    | bool | false        | Whether to schedule via cron regular ClamAV database refreshes independent of performing any scans |
| clamav_cron_minute                  | string | '0'             | Which minute of the hour to run the cron job. |
| clamav_cron_hour                    | string | '0'             | Which hour of the day to run the cron job. |
| clamav_cron_weekday                 | string | '*'             | Which day of week of the to run the cron job. |
| clamav_cron_month                   | string | '*'             | Which month of the year to run the cron job. |
| clamav_scan_path                    | string | '/'             | Path that ClamAV will scan. |
| clamav_file_ignore_pattern          | string | '^/var/log/clamscan\.log$' | Pattern for files to ignore when scanning. |
| clamav_dir_ignore_pattern           | string | '^/hana/|^/dev/|^/usr/sap/|^/backup/|^/sys|^/proc' | Pattern for directories to ignore when scanning. |
| clamav_freshclam_http_proxy_address | string | '' | To enable HTTP proxy for freshclam updates, set this value to the address of the HTTP proxy. |
| clamav_freshclam_http_proxy_port    | string | '80' | Port for HTTP proxy for freshclam updates. |
| clamd_enable                        | bool   | false           | Whether to run a ClamAV as a daemon. |
| clamd_logfile                       | string | /var/log/clamd.scan | default location of logfile for clamd |
| clamd_tcpsocket                     | number | 9590            | Port that clamsap vsi will connect        |
| clamd_tcpaddr                       | number | 127.0.0.1       | IP address that clamsap binds to          |

Dependencies
------------

**EPEL:** The EPEL repository must be enabled in order to install the ClamAV package. The `clamav-configure.yml` playbook calls the `epel` role by default, and the `epel` role is defined as a dependency in the `meta/main.yml` meta file.

Security
--------

This role satisfies United States DISA STIGs `RHEL-07-032000:SV-86837r3_rule` and `UBTU-16-030900:SV-92701r1_rule`. The latest RHEL and Ubuntu STIGS can be downloaded from the DISA site: [The latest SLES and RHEL STIGS can be downloaded from the DISA site: https://public.cyber.mil/stigs/compilations/](https://public.cyber.mil/stigs/compilations/)

Example Playbooks
-----------------

The following playbook will install ClamAV and setup a cron job to run its scans:
```
- hosts: all
  become: true

  vars:
    clamav_run_scan: false
    clamav_create_cron_schedule: true
    clamav_remove_cron_schedule: false

  tasks:

  - name: Install the EPEL repository
    include_role:
      name: ../roles/repository-management
    vars:
      epel_repo: 'true'
      redhat_repo: 'true'
      repo_enable: 'true'

  - name: Call the clamav role
    include_role:
      name: clamav
```

The following playbook will install ClamAV and run an ad hoc scan without setting up a cron job:
```
- hosts: all
  become: true

  vars:
    clamav_run_scan: true
    clamav_create_cron_schedule: false
    clamav_remove_cron_schedule: false

  tasks:

  - name: Install the EPEL repository
    include_role:
      name: ../roles/repository-management
    vars:
      epel_repo: 'true'
      redhat_repo: 'true'
      repo_enable: 'true'

  - name: Call the clamav role
    include_role:
      name: clamav
```

Targeted ClamAV Virus Scanning
------------------------------

When `clamav_targeted_scan_script` is set to `true`, role will configure generic scipt on the filesystem that can be used perform on-demand virus scanning against target files or directories on the filesystem.

* Path: `/usr/share/clamav/clamrun-targeted.sh`
* Arguments: (1) accepts absolute or relative path to file or directory to perform virus scan against
* Return Codes:
    * `0` - script execution successful, no viruses detected within target path
    * `1` - script execution successful, viruses detected within target path
    * other - script execution unsuccessful

Example usage:

```
/usr/share/clamav/clamrun-targeted.sh /<path>/<to>/<folder-or-file>
```

Source
------

This role is based off of the ClamAV role originally created for SAC, which can be found here: [https://gitlab.core.sapns2.us/sac-dev/ns2-kontrolle/tree/master/roles/clamav](https://gitlab.core.sapns2.us/sac-dev/ns2-kontrolle/tree/master/roles/clamav)

License
-------

BSD

Author Information
------------------

* Matt Bittner (i869415) matt.bittner@sap.com
* Devon Thyne (i513825) devon.thyne@sap.com
* Alijohn Ghassemlouei (i516349) a.ghassemlouei@sap.com
* Mark Carey (i745422) mark.carey@sap.com
