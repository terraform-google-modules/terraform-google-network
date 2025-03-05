/*
  Description: Terraform layer-00 input variables
  Comments: N/A
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}

##### Subnet Variables
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}
variable "tenant_vpc_cidr_block" {
  description = "CIDR superblock for the tenant VPCs"
  type        = list(string)
}
variable "subnet_main01_infrastructure_1a_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1a subnet"
}
variable "subnet_main01_infrastructure_1b_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1b subnet"
}
variable "subnet_main01_infrastructure_1c_cidr_block" {
  description = "CIDR block for the main01_infrastructure_1c subnet"
}
variable "subnet_main01_edge_1a_cidr_block" {
  description = "CIDR block for the main01_edge_1a subnet"
}
variable "subnet_main01_edge_1b_cidr_block" {
  description = "CIDR block for the main01_edge_1b subnet"
}
variable "subnet_main01_edge_1c_cidr_block" {
  description = "CIDR block for the main01_edge_1c subnet"
}

##### Route 53 Variables
variable "dns_fqdn" {
  description = "Sets the FQDN of the private hosted zone in Route 53 for the DNS Domain"
}
variable "dns_authorization_vpc_ids" {
  description = "This is used to authorize VPCs in other accounts to be associated to the internal FQDN. This will only authorize. Association should be done from the other account provider."
  type        = list(object({ vpc_id = string, region = string, description = string }))
  default     = []
}

##### Whitelisted IP Addresses
variable "whitelisted_ip_addresses" {
  description = "Map of ip addresses to whitelist access to HashiCorp Vault"
  type        = map(any)
}
