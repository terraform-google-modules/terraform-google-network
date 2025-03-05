CRE S4 PCE customer#### Azure DNS Records Integration with AWS Route53
=====================================================================

Manages DNS records for Azure services within AWS Route53 hosted zones.

Dependencies
------------

* Terraform v1.0
* AWS IAM privileges to managed related services in DNS provider account (`s4-cre-pce-g`)
* Azure storage account container named `ns2-cre-s4-pce-terraform` for terraform backend statefiles.

Author Information
------------------

* Devon Thyne [devon.thyne@sapns2.com](mailto:devon.thyne@sapns2.com)
