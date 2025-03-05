aws-cloudwatch-agent
====================
This role installs the AWS CloudWatch Logs Agent.

Requirements
------------

This role will install CloudWatch on the following RedHat, CentOS, Amazon Linux, Ubuntu, and Debian distributions.

* RedHat
  * 6
  * 7
  * 8
* CentOS
  * 6
  * 7
* Amazon Linux
  * 1
  * 2
* Ubuntu
  * 14.04
  * 16.04
  * 18.10
* Debian
  * buster
  * jessie
  * sid
  * stretch
* Suse Linux Enterprise Server
  * 15

> __Note:__ Currently (2020-11-06), AWS CloudWatch Agent will fail on instances where FIPS mode is enabled. AWS Support Case #7490840431 has been submitted and AWS is actively working on resolution.

In order to use this role, your EC2 instance must have an IAM role attached with the `CloudWatchAgentServerPolicy` policy configured. The `CloudWatchAgentServerPolicy` policy is required for the cloudwatch agent to interact with CloudWatch Logs.

Features
--------
* Downloads and installs the CloudWatch Agent
* Provides a configuration wizard tool to speed up the process of configuring the CloudWatch Agent
* Reloads the service whenever the configuration is changed

Usage for New Configurations
----------------------------
Run the aws-cloudwatch-agent ansible playbook using this command:
```
$ ansible-playbook aws-cloudwatch-agent.yml -i 10.0.0.1,
```

The aws-cloudwatch playbook automatically installs and starts the CloudWatch Logs Agent. To specify a preset collection of application logs you wish to monitor, enter `--extra-vars application_preset_selection=sap` or `--extra-vars application_preset_selection=hana` or `--extra-vars application_preset_selecton=openvpn` via the command line when running the playbook.

The final step is to validate that the agent is running by using the binary or systemd using the following syntax:
```
$ service amazon-cloudwatch-agent status
$ amazon-cloudwatch-agent -a status
```

The output should resemble the following:
```
{
  "status": "running",
  "starttime": "2019-07-03T17:58:29+0000",
  "version": "1.219020.0"
}
```

If the agent is stopped, you can start it manually using the binary or systemd:
```
$ service amazon-cloudwatch-agent start
$ amazon-cloudwatch-agent -a start
```

You should momentarily see the specified log groups and log streams show up in the AWS Console under CloudWatch > Logs. The default configuration file for the CloudWatch Logs Agent can be found in templates/agent/amazon-cloudwatch-agent.json.j2. It can be modified manually as required by the user.

> __Note:__ A running Amazon CloudWatch Logs Agent will need to be stopped and restarted for any configuration changes to take effect.

Role Variables
--------------

```yaml
# posible values:
# - "{{ lookup('file', 'files/your-cloudwatch-config.json') | from_json }}" where your-cloudwatch-config.json is your custom
#   configuration file according to docs reference.
# - "{{ lookup('file', 'files/your-cloudwatch-config.yaml') | from_yaml }}" where your-cloudwatch-config.yaml is your custom
#   configuration file according to docs reference.
#
# Also is possible to define inline configuration as YAML
#    cwa_conf_json_file_content:
#      metrics:
#        append_dimensions:
#          AutoScalingGroupName: "${!aws:AutoScalingGroupName}"
#          ImageId: "${!aws:ImageId}"
#          InstanceId: "${!aws:InstanceId}"
#          InstanceType: "${!aws:InstanceType}"
#        metrics_collected:
#          mem:
#            measurement:
#              - mem_used_percent
#          swap:
#            measurement:
#              - swap_used_percent
#
# reference: https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html
# default value: ""
# notes:
# * when is empty the role deploy a custom json configuration via template
cwa_conf_json_file_content: ""
```

```yaml
# posible values:
# - "ec2"
# - "onPremise"
# default value: "ec2"
# notes:
# * not necessary when you deploy the agent into AWS, default value is fine.
# * when you set the value 'onPremise' is because you installed the agent outside AWS, so is necessary to set the variables "cwa_aws_region", "cwa_access_key", "cwa_secret_key" also
cwa_agent_mode: "{{ cwa_agent_mode }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/general/latest/gr/rande.html
# default value: "us-gov-west-1"
# notes:
# * This is the region where the agent have access to push logs/metrics, only necessary when use **cwa_agent_mode:** "onPremise"
cwa_aws_region: "{{ cwa_aws_region }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
# default value: "AmazonCloudWatchAgent"
# notes:
# * Only necessary when use **cwa_agent_mode:** "onPremise", you could use other profile if it is configured properly
cwa_profile: "{{ cwa_profile }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
# - https://docs.ansible.com/ansible/latest/user_guide/vault.html
# default value: ""
# notes:
# * This is the region where the agent have access to push logs/metrics, only necessary when use **cwa_agent_mode:** "onPremise"
cwa_access_key: "{{ cwa_access_key }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
# - https://docs.ansible.com/ansible/latest/user_guide/vault.html
# default value: ""
# notes:
# * This is the region where the agent have access to push logs/metrics, only necessary when use **cwa_agent_mode:** "onPremise"
cwa_secret_key: "{{ cwa_secret_key }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
# default value: ""
cwa_http_proxy: "{{ cwa_http_proxy }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
# default value: ""
cwa_https_proxy: "{{ cwa_https_proxy }}"
```

```yaml
# posible values:
# - https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
# default value: "169.254.169.254"
# * Always disable proxy for aws metadata ip (169.254.169.254)
cwa_no_proxy: "169.254.169.254"
```

```yaml
# posible values:
# - https://linux.die.net/man/8/logrotate
# default value: "10M"
cwa_logrotate_file_size: "{{ cwa_logrotate_file_size }}"
```

```yaml
# posible values:
# - https://linux.die.net/man/8/logrotate
# default value: 5
cwa_logrotate_files: "{{ cwa_logrotate_files }}"
```

```yaml
# posible values:
# default,hana, sap, openvpn
# default value: "default"
application_preset_selection: ""
```

```yaml
# possible values:
# - instance_id, hostname
# default value: "instance_id"
cwa_default_log_stream_name: "{{ instance_id }}"
```

```yaml
# possible values:
# - true, false
# default value: true
cwa_install_metrics: true
```

Example Playbook
----------------
```
  - hosts: all
    gather_facts: yes
    become: true
    vars:
      aws_region: us-gov-west-1

    tasks:
    - name: Install EPEL
      include_role:
        name: ../roles/repository-management
      vars:
        epel_repo: 'true'
        redhat_repo: 'true'
        repo_enable: 'true'

    - name: Install AWS CloudWatch Agent
      include_role:
        name: aws-cloudwatch-agent
```

Author Information
------------------

* Katja Cresanti (Katja.Cresanti@sapns2.com)

This code was adapted from [amazon_cloudwatch_agent] (https://galaxy.ansible.com/christiangda/amazon_cloudwatch_agent) on ansible-galaxy. The original source code is available in [christiangda's GitHub repository] (https://github.com/christiangda/ansible-role-amazon-cloudwatch-agent).
