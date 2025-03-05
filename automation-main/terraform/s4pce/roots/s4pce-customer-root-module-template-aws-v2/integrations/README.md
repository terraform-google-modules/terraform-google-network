S4-PCE Integrations
===================

This space includes the Terraform code to connect S4-PCE infrastructure with other networks.

Owners
------

This is a production environment. Changes to this environment should follow proper procedure and notifications to the following individual(s):

* S4-PCE System Owner
* S4-PCE Operations Owner

Dependencies
------------

* Terraform 1.0
* AWS Administrator level privileges or privileges to manage VPC, S3, EC2, EIPs and other related services
* AWS S3 bucket to store state
* aws-endpoint-services module
* aws-iam-role module
* aws-instance module
* S4-PCE-customer-infrastructure module
* terraform-null-context module

S4-PCE Integration Module Details
------------------------------

dev-management : Creates the necessary associations to connect to IBP-Dev Management
edge-vpc/layer-00 : Creates a simulated "Customer Edge" network.
edge-vpc/aws-workspace : Creates a peer to allow IBP-Dev Workspace to connect to the edge.
