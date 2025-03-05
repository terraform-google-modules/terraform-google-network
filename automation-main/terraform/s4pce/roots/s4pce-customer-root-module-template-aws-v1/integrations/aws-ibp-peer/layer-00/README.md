aws-ibp-peer/layer-00
==========================

This space includes the Terraform code to make a VPC Peer to an IBP Backend

Dependencies
------------

* Terraform v1.0
* AWS IAM privileges to managed related services in all necessary accounts
* AWS Profiles for both S4 and IBP Accounts

Usage Instructions
------------------

1. Log into both environments
```
saml2aws login -a <ibp profile>
saml2aws login -a <s4pce profile>
```

2. Export your s4pce profile as the aws default.
```
export AWS_PROFILE=<s4pce profile>
```

3. Update the terraform.tfvars with suitable values
```
ibp_customer = "customer####"
ibp_profile = "<ibp profile>"
```

4. Execute Terraform



Author Information
------------------

* Louis Lee [louis.lee@.com](mailto:louis.lee@sap.com)
