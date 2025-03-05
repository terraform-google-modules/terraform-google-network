Telegraf
========

Installs [telegraf](https://www.influxdata.com/time-series-platform/telegraf/)
a tool to collect metrics and other information relevant to validating that a
system is in proper health.

Requirements
------------

- RHEL 8.x
- Ubuntu 18.04
- Suse 15

This role also requires that there is an ElasticSearch cluster configured, and
requires a username/password in that ElasticSearch cluster that has the
following roles: `monitoring_user` and a `telegraf` role

The `telegraf` role should have the following permissions:

- cluster privileges: `monitor`, `manage`
- Index privileges:
    - Indices: `ns2-metrics-telegraf-*`
    - Privileges: `create`, `create_index`, `write`

This will allow `telegraf` to sniff for any additional hosts, and create the
relevant indexes as the data is streamed to Elastic Search.


Role Variables
--------------

- `telegraf_version`: The telegraf version to install, when installing from an S3
    bucket.

    (Default: "1.12.1")

- `telegraf_s3_binaries_url`: An URL to the telegraf directory path, should contain
    sub-folders that match the following:

    ```
    telegraf/
        1.21.1/
            telegraf-1.21.1-amd64.deb
            telegraf-1.21.1-1.x86_64.rpm
        1.21.0/
            telegraf-1.21.0-amd64.deb
            telegraf-1.21.0-1.x86_64.rpm
    ```

    This is for installation in environments where there is no external
    internet access. The preferred method is to leave this blank, and to
    install the latest version that is available from upstream.

    (Default: "")


- `telegraf_elastic_primary_nodes`: List of primary ElasticSearch nodes, this
    should be at least 1 URL in the format of:

    ```
    https://elastic01.example.com:9200/
    ```

    Additional URL's will be automatically discovered by sniffing the nodes
    endpoint from Elastic Search.

    Example with multiple URL's:

    ```
    telegraf_elastic_primary_nodes:
        - https://elastic01.example.com:9200/
        - https://elastic02.example.com:9200/
        - https://elastic03.example.com:9200/
    ```

    (Default: [])

- `telegraf_elastic_user`: The username to use when connecting to the Elastic
    Search cluster.

    (Default: `telegraf`)

- `telegraf_elastic_password`: The password to use when connecting to the
    Elastic Search cluster.

    (Default: `logging`)

- `telegraf_elastic_index_prefix`: The index prefix to use when creating the
    indexes on the ElasticSearch cluster.

    (Default: ns2-metrics-telegraf)

- `telegraf_elastic_template_name`: Telegraf will attempt to install a default
    template, this sets that template name.

    (Default: `ns2-telegraf-from-telegraf`)

- `telegraf_elastic_default_pipeline`: Set the default ElasticSearch pipeline
    which should be used when telegraf successfully sends data to
    ElasticSearch.

    (Default: `ns2_telegraf`)

- `telegraf_monitor_profiles`: A list of profiles to enable on this system.
    Each profile is either named after a singular service (ssh for example) or
    after a suite of services that the host is hosting (hana, elasticsearch,
    sapapp-java)

    These enable additional monitors, such as URL monitors, file monitors or
    port monitors.

    When deploying this role, multiple profiles can and should be selected to
    best allow metrics reporting/uptime reporting.

    Example:

    ```
    telegraf_monitor_profiles:
        - ssh
        - elasticsearch
    ```

    (Default: [])

- `system_instance_number`: Some of the port monitors require a
    `system_instance_number` so that they may appropriately configure the ports
    to monitors. This should be provided by the playbook as necessary for the
    monitor profiles that are enabled in the above setting.

    NOTE: MUST be a string so that it is not treated by YAML as an octal
    number, so quoting is required.

    (Defualt: `'00'`)


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
  - hosts: all
    tasks:
      - name: Install/configure Telegraf
        ansible.builtin.include_role:
          name: telegraf
          vars:
            telegraf_monitor_profiles:
                - ssh
```

License
-------

BSD

Author Information
------------------

* Bert JW Regeer (bert.regeer@sapns2.com)
