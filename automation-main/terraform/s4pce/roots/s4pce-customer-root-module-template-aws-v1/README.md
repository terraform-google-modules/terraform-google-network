s4pce-customer-root-module-template-aws
=======================================
This is a generic terraform customer template for Sovereign Cloud S4/HANA Private Cloud Edition.

This terraform code can be used with the replacement of certain `EXAMPLE_` values as outlined below.

## Template Variables
The Following variables should be replaced with deployment specific values.

| Variable Name | Description |
| ------------- | ----------- |
| EXAMPLE_SOURCE | Relative path to the terraform source module repository.
| #EXAMPLE_BACKEND_region | Line for the Backend configuration Region
| #EXAMPLE_BACKEND_bucket | Line for the Backend configuration Bucket
| #EXAMPLE_BACKEND_dynamodb_table | Line for the Backend configuration DynamoDB Table
| #EXAMPLE_BACKEND_key | Line for the Backend configuration Key
| #EXAMPLE_prevent_destroy | For Development use only, disables accidental deletion prevention.
| EXAMPLE_REGION | Region Value
| EXAMPLE_BUCKET | Bucket Value
| EXAMPLE_DYNAMODB | Dynamo DB Value
| EXAMPLE0001 | Customer Identifier
| E001 | Customer Key Identifier
| EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME | Tagging Value
| EXAMPLE_SECURITY_BOUNDARY | Tagging Value, used in name generation
| EXAMPLE_ENVIRONMENT | Tagging Value, used in name generation
| EXAMPLE_ORGANIZATION_FRIENDLY_NAME | Tagging Value
| EXAMPLE_ORGANIZATION | Tagging Value, used in name generation
| EXAMPLE_OWNER_EMAIL |  Tagging Value
| EXAMPLE_MANAGEMENT_KEY | Management Key Value, typically "management". Can be used for testing alternate management deployments
| EXAMPLE_MANAGEMENT_WORKSPACE | Management Workspace Value. Remove for single-region (non-workspace) management deployments

## Example Use cases
### Method1 Search and Replace
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
```sh
find ./ -type f -exec sed -i '' -e 's/#EXAMPLE_BACKEND_//g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_DYNAMODB/ibp-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../../automation|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.internal/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_WORKSPACE/west/g' {} \;
```
* Follow SOP for terraform deployment.


### Method2 Search and Replace + backend.tfvar
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
```sh
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_DYNAMODB/ibp-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../../automation|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.internal/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_WORKSPACE/west/g' {} \;

```
* Follow SOP for `backend.tfvar` terraform deployment

## SOP for terraform deployment

#### Prep
Set the following values for your local terraform environment.
```sh
# Navigate to root folder
flag=""
unset TF_WORKSPACE
export customer_root=$(pwd)
# validate path
cd $customer_root
pwd
```

### layer-00
* adjust CIDR in terraform.tfvars, see [appendix cidr ranges](#appendix-example-cidr-divisions)
```sh
code --goto "$customer_root/layer-00/terraform.tfvars:22"

# flag="--auto-approve"
export flag=""
unset TF_WORKSPACE

cd $customer_root/layer-00;
tfenv use min-required
terraform init
terraform apply $flag
```


### layer-01
```sh

# flag="--auto-approve"
export flag=""
unset TF_WORKSPACE

cd $customer_root/layer-01
tfenv use min-required
terraform init
terraform apply $flag
```


### layer-02
* Add SSH Key to `layer-02/terraform.tfvars/ssh_main01_public_key`
* adjust `layer-02/instances.auto.tfvars` as desired
```sh
code --goto "$customer_root/layer-02/terraform.tfvars:16:26"
code --goto "$customer_root/layer-02/instances.auto.tfvars:7:1"

# flag="--auto-approve"
export flag=""
unset TF_WORKSPACE

cd $customer_root/layer-02
tfenv use min-required
terraform init
terraform apply $flag
```

## OPTIONAL Modules Below
### Layer-Options
This is a special template for optional Terraform layers.

The template provides output values from core terraform layers as metadata.  Custom code can be written and deployed in this layer.
Sovereign Cloud Single Tenant will offer limited support for this layer.

Existing examples of potential customizations are included in the subfolders.  Move the files into the root folder or create your own as desired.
```sh
cd $customer_root/layer-options
# Example Custom Submodule
cp aws-qtm/* ./
code --goto "$customer_root/layer-options/aws-qtm.auto.tfvars

tfenv use min-required; terraform init
terraform apply
```

### layer-ha
```sh
cd $customer_root/layer-ha; tfenv use min-required; terraform init
terraform apply
```

### s4-management
```sh
cd $customer_root/integrations/s4-management/layer-00; tfenv use min-required; terraform init
terraform apply
```

### Bridge Network
```sh
cd $customer_root/integrations/edge-vpc/layer-00; tfenv use min-required; terraform init
terraform apply
```


### Customer Hosted Zone
```sh
code --goto "$customer_root/integrations/customer-hosted-zone/terraform.tfvars:11:1"
cd $customer_root/integrations/customer-hosted-zone; tfenv use min-required; terraform init
terraform apply
```


### Reverse Private Links
```sh
code --goto "$customer_root/integrations/edge-vpc/reverse-private-links/endpoints.auto.tfvars:7:1"
cd $customer_root/integrations/edge-vpc/reverse-private-links; tfenv use min-required; terraform init
terraform apply
```

### Gardener / SFTP (FILE Transfer Module)
Requires:
* Management Gardener
* Customer Layer-00
* Customer Layer-01
* Customer Layer-02
* Customer Integrations/"management" peer
* Direct access from Terraform Controller to the Customer Subnets is required.
  * The storage gateway require access via port 80 for activation.

This integration module will add an RDS instance and S3 bucket for use with SFTPGo.

* Adjust the region
* Adjust the sftpgo_db_master_user_password.  This is intended to be rotated after initial setup.
```sh
code --goto "$customer_root/integrations/gardener/sftpgo/terraform.tfvars"

# flag="--auto-approve"
export flag=""
unset TF_WORKSPACE

cd $customer_root/integrations/gardener/sftpgo
tfenv use min-required
terraform init
terraform apply $flag
```

### AWS Workspace
```sh
cd $customer_root/integrations/edge-vpc/aws-workspace; tfenv use min-required; terraform init
terraform apply
```

### DNS Steering
* Adjust terraform tfvars
```sh
code --goto "$customer_root/integrations/edge-vpc/dns-steering/terraform.tfvars"
cd $customer_root/integrations/edge-vpc/dns-steering; tfenv use min-required; terraform init
terraform apply
```

### Audit VPN
* update `terraform.tfvars/ssh_auditor_key`
```sh
code --goto "$customer_root/integrations/edge-vpc/audit-vpn/terraform.tfvars:15:20"
cd $customer_root/integrations/edge-vpc/audit-vpn; tfenv use min-required; terraform init
terraform apply
```

## Terraform Destroy Order
```sh
# export flag="--auto-approve"
export flag=""
cd $customer_root/integrations/gardener/sftpgo; terraform destroy $flag
cd $customer_root/integrations/aws-ibp-peer/layer-00; terraform destroy  $flag
cd $customer_root/integrations/bucket-replication/layer-00; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/dns-steering; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/audit-vpn; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/aws-workspace; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/reverse-private-links; terraform destroy $flag
cd $customer_root/integrations/customer-hosted-zone; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/layer-00; terraform destroy $flag
cd $customer_root/integrations/s4-management/layer-00; terraform destroy $flag
cd $customer_root/integrations/dev-management/layer-00; terraform destroy $flag
cd $customer_root/layer-ha; terraform destroy $flag
cd $customer_root/layer-02; terraform destroy $flag
cd $customer_root/layer-01; terraform destroy $flag
cd $customer_root/layer-00; terraform destroy $flag
```




## Appendix Example CIDR Divisions:
**CIDR/19**
NOTE: This is the original recommended CIDR Range
```terraform
vpc_cidr_block                         = "10.0.0.0/19"
subnet_production_1a_cidr_block        = "10.0.0.0/23"
subnet_production_1b_cidr_block        = "10.0.2.0/23"
subnet_production_1c_cidr_block        = "10.0.4.0/23"
subnet_quality_assurance_1a_cidr_block = "10.0.6.0/23"
subnet_quality_assurance_1b_cidr_block = "10.0.8.0/23"
subnet_quality_assurance_1c_cidr_block = "10.0.10.0/23"
subnet_development_1a_cidr_block       = "10.0.12.0/23"
subnet_development_1b_cidr_block       = "10.0.14.0/23"
subnet_development_1c_cidr_block       = "10.0.16.0/23"
subnet_edge_1a_cidr_block              = "10.0.20.0/26"
subnet_edge_1b_cidr_block              = "10.0.20.64/26"
subnet_edge_1c_cidr_block              = "10.0.20.128/26"
```

**CIDR/20**
```terraform
vpc_cidr_block                         = "10.0.0.0/20"
subnet_production_1a_cidr_block        = "10.0.0.0/25"
subnet_production_1b_cidr_block        = "10.0.0.128/25"
subnet_production_1c_cidr_block        = "10.0.1.0/25"
subnet_quality_assurance_1a_cidr_block = "10.0.2.0/25"
subnet_quality_assurance_1b_cidr_block = "10.0.2.128/25"
subnet_quality_assurance_1c_cidr_block = "10.0.3.0/25"
subnet_development_1a_cidr_block       = "10.0.4.0/25"
subnet_development_1b_cidr_block       = "10.0.4.128/25"
subnet_development_1c_cidr_block       = "10.0.5.0/25"
subnet_edge_1a_cidr_block              = "10.0.8.0/26"
subnet_edge_1b_cidr_block              = "10.0.8.64/26"
subnet_edge_1c_cidr_block              = "10.0.8.128/26"
```

**CIDR/21**
```terraform
vpc_cidr_block                         = "10.0.0.0/21"
subnet_production_1a_cidr_block        = "10.0.0.0/25"
subnet_production_1b_cidr_block        = "10.0.0.128/25"
subnet_production_1c_cidr_block        = "10.0.1.0/25"
subnet_quality_assurance_1a_cidr_block = "10.0.1.128/25"
subnet_quality_assurance_1b_cidr_block = "10.0.2.0/25"
subnet_quality_assurance_1c_cidr_block = "10.0.2.128/25"
subnet_development_1a_cidr_block       = "10.0.3.0/25"
subnet_development_1b_cidr_block       = "10.0.3.128/25"
subnet_development_1c_cidr_block       = "10.0.4.0/25"
subnet_edge_1a_cidr_block              = "10.0.5.0/26"
subnet_edge_1b_cidr_block              = "10.0.5.64/26"
subnet_edge_1c_cidr_block              = "10.0.5.128/26"
```


**CIDR/22**
```terraform
vpc_cidr_block                         = "10.0.0.0/22"
subnet_production_1a_cidr_block        = "10.0.0.0/26"
subnet_production_1b_cidr_block        = "10.0.0.64/26"
subnet_production_1c_cidr_block        = "10.0.0.128/26"
subnet_quality_assurance_1a_cidr_block = "10.0.1.0/26"
subnet_quality_assurance_1b_cidr_block = "10.0.1.64/26"
subnet_quality_assurance_1c_cidr_block = "10.0.1.128/26"
subnet_development_1a_cidr_block       = "10.0.2.0/26"
subnet_development_1b_cidr_block       = "10.0.2.64/26"
subnet_development_1c_cidr_block       = "10.0.2.128/26"
subnet_edge_1a_cidr_block              = "10.0.3.0/26"
subnet_edge_1b_cidr_block              = "10.0.3.64/26"
subnet_edge_1c_cidr_block              = "10.0.3.128/26"
```


**CIDR/23**
```terraform
vpc_cidr_block                         = "10.0.0.0/23"
subnet_production_1a_cidr_block        = "10.0.0.0/27"
subnet_production_1b_cidr_block        = "10.0.0.32/27"
subnet_production_1c_cidr_block        = "10.0.0.64/27"
subnet_quality_assurance_1a_cidr_block = "10.0.0.96/27"
subnet_quality_assurance_1b_cidr_block = "10.0.0.128/27"
subnet_quality_assurance_1c_cidr_block = "10.0.0.160/27"
subnet_development_1a_cidr_block       = "10.0.0.192/27"
subnet_development_1b_cidr_block       = "10.0.0.224/27"
subnet_development_1c_cidr_block       = "10.0.1.0/27"
subnet_edge_1a_cidr_block              = "10.0.1.32/27"
subnet_edge_1b_cidr_block              = "10.0.1.64/27"
subnet_edge_1c_cidr_block              = "10.0.1.96/27"
```


**CIDR/24**
* NOTE: This CIDR/24 is not large enough to support a full Bridge Network Deployment
```terraform
vpc_cidr_block                         = "10.0.0.0/24"
subnet_production_1a_cidr_block        = "10.0.0.0/28"
subnet_production_1b_cidr_block        = "10.0.0.16/28"
subnet_production_1c_cidr_block        = "10.0.0.32/28"
subnet_quality_assurance_1a_cidr_block = "10.0.0.48/28"
subnet_quality_assurance_1b_cidr_block = "10.0.0.64/28"
subnet_quality_assurance_1c_cidr_block = "10.0.0.80/28"
subnet_development_1a_cidr_block       = "10.0.0.96/28"
subnet_development_1b_cidr_block       = "10.0.0.112/28"
subnet_development_1c_cidr_block       = "10.0.0.128/28"
subnet_edge_1a_cidr_block              = "10.0.0.144/28"
subnet_edge_1b_cidr_block              = "10.0.0.160/28"
subnet_edge_1c_cidr_block              = "10.0.0.176/28"
```
