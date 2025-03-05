---
# Customer Inventory: ${customer}
# Synopsis: Ansible inventory to be used with all IBP playbooks
# Comment: Auto-Generated by terraform/customer/layer-options/ansible-inventory
all:
  hosts:
  vars:
    efs_staging_ip: ${efs_staging_ip}
    efs_usrsaptrans_ip: ${efs_usrsaptrans_ip}
    saphostagent_source: /staging/ibp/Build/${upper(inventory_vars.prod_release)}/SAPHOSTAGENT
    aws_region: ${lower(aws_region)}
    customer_number: ${inventory_vars.customer_number}
    input_hostfile_fqdn: ${lower(inventory_vars.input_hostfile_fqdn)}
    ### Post Provisioning Variables
    #### Postfix
    input_postfix_relay_smtp_address: ___MAIL.RELAY.FROM.IBP.MANAGEMENT.INTERNAL___
    input_postfix_relay_smtp_port: 25

    #### Nessus
    input_nessus_manager_address: ___NESSUS.MANAGER.FROM.SMS.INTERNAL___
    input_nessus_agent_group: ___DEFINED-FROM-SMS-IBP___
    input_nessus_s3_bucket_aws_region: ___DEFINED-FROM-SMS-REGION___
    input_nessus_s3_bucket_name: ___DEFINED-FROM-SMS-NESSUS-INSTALL-BUCKET___
    input_nessus_s3_bucket_path: media/tenable

  children:
### Product Groups
    webdispatcher:
      hosts:
        ${instance_map["instance_webdispatcher"].additional_cnames[0]}:
      vars:
        webdispatcher_tar_source: /staging/webdispatcher/Build/${upper(inventory_vars.webdispatcher_release)}
    cpids:
      hosts:
        ${instance_map["instance_cpids"].additional_cnames[0]}:
      vars:
        cpids_tar_source: /staging/cpids/Build/${upper(inventory_vars.cpids_release)}
        cpids_alb_cname: ${cpids_alb_cname}
    ibpapp:
      hosts:
        ${instance_map["instance_production_ibpapp"].additional_cnames[0]}:
        ${instance_map["instance_staging_ibpapp"].additional_cnames[0]}:
    ibpdb:
      hosts:
        ${instance_map["instance_production_ibpdb"].additional_cnames[0]}:
        ${instance_map["instance_staging_ibpdb"].additional_cnames[0]}:
### Landscape Groups
    dataservices:
      children:
        webdispatcher:
        cpids:
      vars:
    staging:
      hosts:
        ${instance_map["instance_staging_ibpapp"].additional_cnames[0]}:
        ${instance_map["instance_staging_ibpdb"].additional_cnames[0]}:
      vars:
        hana_tar_source: /staging/ibp/Build/${upper(inventory_vars.nonprod_release)}/DB
        sapapp_tar_source: /staging/ibp/Build/${upper(inventory_vars.nonprod_release)}/APP
        sid: ${upper(inventory_vars.staging_sid)}
        suffix: stg
    test:
      hosts:
      vars:
        hana_tar_source: '/staging/ibp/Build/${upper(inventory_vars.nonprod_release)}/DB'
        sapapp_tar_source: '/staging/ibp/Build/${upper(inventory_vars.nonprod_release)}/APP'
        sid:
        suffix: 'tst'
    production:
      hosts:
        ${instance_map["instance_production_ibpapp"].additional_cnames[0]}:
        ${instance_map["instance_production_ibpdb"].additional_cnames[0]}:
      vars:
        hana_tar_source: /staging/ibp/Build/${upper(inventory_vars.prod_release)}/DB
        sapapp_tar_source: /staging/ibp/Build/${upper(inventory_vars.prod_release)}/APP
        sid: ${upper(inventory_vars.production_sid)}
        suffix: prd
    disaster_recovery:
      hosts:
      vars:
        hana_tar_source: '/staging/ibp/Build/${upper(inventory_vars.prod_release)}/DB'
        sapapp_tar_source: '/staging/ibp/Build/${upper(inventory_vars.prod_release)}/APP'
        suffix: 'prd-dr'
        sid:
...
