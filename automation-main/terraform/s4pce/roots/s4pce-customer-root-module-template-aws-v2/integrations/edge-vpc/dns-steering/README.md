## Description
This root module will use the `terraform-aws-dns-steering` module to create a customer specific Route53 zone.  Records will be added for each `endpoint` into this newly created zone.  This zone will allow customers to do a one-time setup for their local DNS to point to these `steering` records.  Subsequent changes to endpoints will only require an update to the `steering` records with no interaction on the customer side.

## Terminology
* `terraform-aws-dns-steering` - [Sovereign Cloud Shared Terraform Module](https://gitlab.core.sapns2.us/scs/shared/terraform/modules/-/tree/main/terraform-aws-dns-steering)
* `steering record` - A DNS CNAME Record that acts as an intermediary record.
* `endpoint` - An AWS Private Link Endpoint which provides a webservice.

## Explanation
AWS Route53 Records for Private Link Endpoints are generated automatically upon creation. If any `endpoint` is redeployed, it will require an update to the customer DNS records that reference the AWS Route53 Endpoint Records.

A `steering record` is created as an intermediary record. If the `endpoint` created or destroyed, the `steering record` can be automatically updated by the terraform scripts.

For a more details, please refer to [Whitepaper: Single Tenant DNS Steering](https://gitlab.core.sapns2.us/scs/s4pce/documentation/-/blob/main/maintain/runbooks/whitepaper-pce-dns-steering.md)


## Instructions.
1. Run Terraform `layer-00`, `layer-01`, `layer-02`, and `integrations/edge-vpc/layer-00`.
1. Log into the Authoritative DNS AWS Account. Make sure it is assigned to an AWS Profile.
1. Log into the Customer's Backend AWS Account. Set the current environment to this AWS Profile
1. Fill out the values in `terraform.tfvars`
1. Run terraform.
1. Re-Run terraform for any subsequent changes to `integrations/edge-vpc/layer-00`

For a more detailed runbook, [see the following.](https://gitlab.core.sapns2.us/scs/s4pce/documentation/-/blob/main/maintain/runbooks/runbook-pce-dns-steering.md)
