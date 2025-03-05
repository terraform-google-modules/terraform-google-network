/*
  Description: Terraform layer-00 input variables; Universal variables for CRE SMS Management layer-00 infrastructure
  Layer: 00
  Comments:
    - Rename this file to terraform.tfvars to use
    - Uncomment and populate the missing variables before use
    - 'vpc_prefix' should be a unique naming prefix globally in the account
    - 'vpc_cidr_block' and all associated subnets should have unique CIDR blocks in the account
*/

### AWS Variables
aws_region = "us-gov-west-1"

// Generate a keypair with `ssh-keygen -m PEM -t rsa -N '' -C auditor_key -f ./auditor_key.pem` .  Store the private key in vault
ssh_auditor_key = ""

image_openvpn_name = "Golden-SCS-Ubuntu-20.04-OpenVPN-V*"
ami_owner_default  = 156506675147

### Uncomment and populate these values before running terraform
// build_user = ""
