cloud-identify
==============

Leverages metadata endpoints to parse information about current cloud provider target host is running within.

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Ansible 2.9+
* Required binaries:
  * `curl`
* Supports cloud provider detection for:
  * AWS
  * Azure
  * GCP

Role Inputs
-----------

* `aws_instance_id_command` - shell command to retrieve the ID of an instance in AWS
* `aws_instance_az_command` - curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone
* `azure_virtual_machine_id_command` - shell command to retrieve the ID of a virtual machine in Azure
* `azure_virtual_machine_name_command` - shell command to retrieve the Name of a virtual machine in Azure
* `azure_virtual_machine_location_command` - shell command to retrieve the Location of a virtual machine in Azure
* `gcp_instance_id_command` - shell command to retrieve the ID of an instance in GCP

Role Outputs
------------

* `cloud_provider` - set_fact containing the detected cloud provider the target host is running within
  * `aws` - target host is running in Amazon Web Services Commercial or GovCloud
  * `azure` - target host is running in Azure Public or Government clouds
  * `gcp` - target host is running in Google Cloud Platform
  * `unknown` - target host us running in an unknown cloud that could not be successfully captured by logic contained within this role
* `cloud_partition` - set_fact containing the detected cloud partition the target host is running within
  * (when `cloud_provider` == `aws`)
    * `commercial` - target host is running in Amazon Web Services Commercial
    * `govcloud` - target host is running in Amazon Web Services GovCloud
  * (when `cloud_provider` == `azure`)
    * `public` - target host is running in Azure Public
    * `usgovernment` - target host is running in Azure US Government
  * (when `cloud_provider` == `gcp`)
    * `gcp` - target host is running in Google Cloud Platform
  * (when `cloud_provider` == `unknown`)
    * `unknown` - target host us running in an unknown cloud partition that could not be successfully captured by logic contained within this role
* `machine_id` - the respective cloud system ID of the target host, will take on the format of the respective cloud, will default to the target system's `$( hostname )` if cloud provider detection produces `unknown`
* `machine_name` - the respective cloud system Name of the target host; currently supports only the Azure cloud provider

Author Information
------------------

* Devon Thyne (devon.thyne@sapns2.com)
* Nick Martinez (nick.martinez@sap.com)
