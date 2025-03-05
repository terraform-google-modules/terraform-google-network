aws-cloudwatch-alarms
=====================

This role is used to configure CloudWatch alerts and optionally also SNS subscriptions.

Requirements
------------

* Anisble 2.12+
* Boto
* Boto3
* AWS SNS Topic

Role Variables
--------------

* aws_topic_name: This is the topic name use for creating alarms and subscriptions.
* aws_sns_subscription_email: The variable for the email address being used for creating alarms. If left blank, a subscription will not be configured.
* cw_preset_selection: This is the variable passed to the 'aws-cloudwatch' role which determines which log files to collect when configuring cloudwatch. This defaults to a value of 'default' but it is important that the value is correct for collecting the proper application logs for the system in question.
* cw_alert_threshold_disk_space: The threshold on which diskspace alerts are sent.
* ignore_disks: disks to ignore when creating alarms. Formatted as a list of mount points.
* cw_install_metrics: Flag to enable/disable CloudWatch custom metric gathering and associated Alarms. It defaults to true.

Dependencies
------------

* aws-cloudwatch role
* AWS SNS topic created, with its name supplied in the aws_topic_name variable.

Example Playbooks
-----------------

The following will perform the default functionality of installing/configuring cloudwatch, using the Node tag
on the ec2 instance to determine which log configuration to use. It will then create alarms for all disks on
the instance that aren't in the ignore list, and aren't using the tmpfs filesystem. No subscriptions to the
topic will be created.

```
- hosts: all
  gather_facts: yes
  become: true
  roles:
    - role: ../roles/aws-cloudwatch-alarms
```

The following will do the same as above, but also configure an SNS subscription for the provided email.
```
- hosts: all
  gather_facts: yes
  become: true
  vars:
    aws_sns_subscription_email: 'email@domain.com'
  roles:
    - role: ../roles/aws-cloudwatch-alarms
```

License
-------

BSD

Author Information
------------------

* Richard Breiten (richard.breiten@sapns2.com)
* Will Rivera (william.rivera@sapns2.com)
