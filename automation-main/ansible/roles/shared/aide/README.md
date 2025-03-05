# aide

## Description
An Ansible role to install, configure, and schedule AIDE.

|**Please Note**|
|---|
|*The default settings will deploy the configuration options that come with a default aide.conf after installing the tool.*|
|*This has only been thoroughly tested on Fedora and RHEL7 Operating Systems.  Please open issues if you have a problem on your platform.*|


## Role Variables
| Variable Name | Description | Required | Default Value | Type |
| --- | --- | :---: | --- | :---:|
| aide_pkg | Name of the aide package to install.  Override with a specific version if required. | Yes | "aide" | string |
|aide_conf_path| Path to the aide configuration file | Yes | "/etc/aide.conf"| string |
|aide_update_db| Whether or not to force an update of the aide database on this Role invocation | Yes | False| boolean |
|aide_dbdir| Directory to create the aide database | Yes | "/var/lib/aide" | string |
|aide_logdir | Directory to create aide logs | Yes | "/var/log/aide" | string |
|aide_database_filename| Filename to create the aide database as. | Yes | "aide.db.gz" | string |
|aide_database_out_filename | Filename to create the updated aide database as | Yes | "aide.db.new.gz" | string |
|aide_gzip_dbout | Whether or not to compress the database output file | Yes | True | boolean |
|aide_verbose| Aide's verbosity level. Valid values are 0-255. | Yes | 5 | integer |
|aide_log_level| The log level to use. | Yes | info | string |
|aide_report_level| The report level to use. The available report levels are as follows | yes | changed_attributes | string|
|aide_report_url| List of report URLs | No | ["file:@@{LOGDIR}/aide.log", "stdout"] | list |
|aide_acl_no_symlink_follow | Whether to check ACLs for symlinks or not. | Yes | True | boolean|
|aide_warn_dead_symlinks| Whether to warn about dead symlinks or not.| Yes | False |boolean|
|aide_summarize_changes| Whether  to  summarize  changes  in  the  added,  removed  and  changed  files sections of the report or not|Yes|False|boolean|
|aide_report_attributes|list of default rules to report|No|Undefined|list|
|aide_grouped|Whether to group the files in the report by added, removed and changed files or not.|Yes|False|boolean|/my/ignore/path/2
|aide_ignore_list|(DEPRECATED, will be removed in a future release). Special group definition that lists attributes whose change is to be ignored in the final report.|No|[]|list|
|aide_config_version|The value of config_version is printed in the report and also printed to the database.  This  is  for  informational  purposes only. It has no other functionality.| No | "1" | string |
|aide_cron_schedule_check|Whether or not to setup a cron job for running an aide check|Yes|True|boolean|
|aide_cron_email_notify_recipients|List of email recipients to get an email notification after a cron job.  Leave list empty if you do not want this functionality.|Yes|[]|list|
|aide_cronjob_name | Comment to insert prior to the cronjob in the crontab|Yes|"aide scheduled database checkup"|string|
|aide_cron_sched_min|Minute to schedule the start of the cron job at|No|"0"|string|
|aide_cron_sched_hr|Hour to schedule the start of the cron job at|No|"1"|string|
|aide_cron_sched_day|Day to schedule the start of the cron job at|No|"*"|string|
|aide_cron_sched_mon|Month to schedule the start of the cron job at|No|"*"|string|
|aide_cron_sched_wkd|Weekday to schedule the start of the cron job at|No|"*"|string|
|aide_cron_schedule_update|When true, sets the cron job to update the aide database weekly|Yes|True|Boolean|
|aide_update_cronjob_name|Name of the cron job that updates the database|Yes|aid scheduled database update|String|
|aide_update_cron_sched_hr|cron job for database update setting for hour|Yes|"6"|String|
|aide_update_cron_sched_wkd|cron job for database update setting for weekday|Yes|"1"|String|

## Defining and Undefining aide.conf Variables
```yaml
aide_macros:
  define:
     - name: "Give it a name"
       variable: "Name_of_Variable"
       value: "Value of the variable"
     - name: "DBDIR var"
       variable: "DBDIR"
       value: "/var/lib/aide"
  undefine:
     - name: "Some var to undefine"
       variable: "Name_of_Variable"  #This would effectively undefine the variable we defined above
     - name: "Undefining DBDIR var"
       variable: "DBDIR"
```

## Defining Rules/Groups, Selection paths, and Ignore/Negative Selection Paths
A YAML spec was built to handle all of these items in a relatively organized way.

### Attributes available to a rule
```yaml
aide_rules:
  - name: "My first rule"                                                #Required
    rule: "FIPSR"                                                        #Required
    comment: "Comment to put above this rule declaration"                #Optional
    attributes: []  #List made up of default rules or defined rules      #Required except on special negative rule
    paths:                                                               #Optional
       - "/my/include/path/1"  #Cannot start with '!' see Ignore/Negative Selection Paths
       - "/my/include/path/2"
```

### A Special Rule to handle Ignore/Negative Selection Paths is available

Add a rule to your `aide_rules`: definition with `rule`: negative
Here's an example, and you can also find an example in this Role's defaults/main.yml:
```yaml
aide_rules:
  - name: "My negative/ignore selections"                                #Required
    rule: "negative"                                                     #Required
    paths:                                                             #Required
       - "/my/ignore/path/1"
       - "/my/ignore/path/2"
```
Do not include an '!' in front of the paths, the template logic will automatically do this for you.

### Scheduled Cron Aide Checks
The default is to setup an 'aide --check' in crontab.  Should you wish to change this after already allowing this role to create the cron job, simply switch the variable `aide_cron_schedule_check` to False.  This will remove the cron job from your system's crontab on the next playbook run.  One caveat to be aware of is that the `aide_cronjob_name` variable must match what's currently in the crontab to be removed properly.


## Example Playbook
```yaml
- name: "Install and configure aide"
  hosts: "servers"
  roles:
     - "ahuffman.aide"
```

## License
[MIT](LICENSE)

## Author Information
[Andrew J. Huffman](https://github.com/ahuffman)
Richard Breiten (richard.breiten@sapns2.com)
