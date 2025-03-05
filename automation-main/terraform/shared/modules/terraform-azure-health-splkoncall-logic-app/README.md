Azure Logic App For SplunkOnCall Health Dashboard Terraform Module
==================================================================

This Terraform module creates the Logic App for a single Azure Project as specified by the variables.

Implementation of terraform-azure-health-splkoncall-logic-app Module
====================================================================

This module should be called using terraform infrastructure.

**DO NOT Run the terraform directly from this module folder**

Dependencies
------------
* Terraform >= 0.13
* Rights to manage service principals in the desired Azure Project
* Azure priviledges to managed related services in all necessary accounts
* Access to Azure storage account container to store the terraform state files

Argument Reference
------------------

* `azure_prefix` - Subscription ID of the Azure project
* `azure_subscription_id` - Subscription ID of the Azure project
* `logic_app_name` - Name of the Logic App
* `logic_app_name_action_name` - Action Id provided to the Logic App

Author Information
------------------

* Amitkumar Pandya [amitkumar.pandya@sapns2.com](mailto:amitkumar.pandya@sapns2.com)
