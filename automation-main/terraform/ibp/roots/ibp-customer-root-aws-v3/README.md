# ibp-customer-root-aws-v3
## [TOC]

This is a generic terraform customer root module which can be used as a template for Sovereign Cloud S4/HANA Integrated Business Planning.

This terraform code can be used with the replacement of certain `EXAMPLE_` values as outlined below.

## NOTE on templates folder
This terraform module has forked the original shared templates repository. It has been included to reduce cross-repository dependencies.

## Terraform Layers
| Layer Name | Description |
| ---------- | ----------- |
| layer-00 | This layer creates the critical infrastructure in each region. |
| layer-01 | This layer create additional policies and services in each region. |
| layer-02 | This layer deploys compute resources in each region. |
| integrations/edge-vpc/layer-00 | This layer creates private link endpoints for the bridge network
| integrations/edge-vpc/layer-01 | This layer creates application load balancers for the bridge network
| layer-options | This is an example template of where you can add your own customizations. |


## Template Variables
The Following variables should be replaced with deployment specific values.

| Variable Name | Description |
| ------------- | ----------- |
| EXAMPLE_SOURCE | Relative path to the terraform source module repository.
| #EXAMPLE_BACKEND_region | Line for the Backend configuration Region
| #EXAMPLE_BACKEND_bucket | Line for the Backend configuration Bucket
| #EXAMPLE_BACKEND_dynamodb_table | Line for the Backend configuration DynamoDB Table
| #EXAMPLE_BACKEND_key | Line for the Backend configuration Key
| EXAMPLE_REGION | Region Value
| EXAMPLE_BUCKET | Bucket Value
| EXAMPLE0001 | Customer Identifier
| E001 | Customer Key Identifier
| EXAMPLE_MANAGEMENT_KEY | Management Key Value, typically "management". Can be used for testing alternate management deployments
| EXAMPLE_MANAGEMENT_WORKSPACE | Management Workspace Value. Remove for single-region (non-workspace) management deployments
| EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME | Tagging Value
| EXAMPLE_SECURITY_BOUNDARY | Tagging Value, used in name generation
| EXAMPLE_ENVIRONMENT | Tagging Value, used in name generation
| EXAMPLE_ORGANIZATION_FRIENDLY_NAME | Tagging Value
| EXAMPLE_ORGANIZATION | Tagging Value, used in name generation
| EXAMPLE_OWNER_EMAIL |  Tagging Value

## Example Use cases
### Method1 Search and Replace
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
  * **NOTE**: for MacOS use `sed -i ''`
```sh
find ./ -type f -exec sed -i -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_MANAGEMENT_WORKSPACE/west/g' {} \;
find ./ -type f -exec sed -i -e 's/#EXAMPLE_BACKEND_//g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_DYNAMODB/ibp-terraform/g' {} \;
find ./ -type f -exec sed -i -e 's|EXAMPLE_SOURCE|../../automation|g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.internal/g' {} \;
```
* Follow SOP for terraform deployment.


### Method2 Search and Replace + backend.tfvar
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
  * **NOTE**: for MacOS use `sed -i ''`
```sh
find ./ -type f -exec sed -i '' -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_WORKSPACE/west/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_DYNAMODB/ibp-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../../automation|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.internal/g' {} \;
```
* Follow SOP for `backend.tfvar` terraform deployment


## SOP for terraform deployment

### Prep
Set the following values for your local terraform environment.
#### Set Env Vars
* Navigate to your customer's root folder.
```sh
export flag=""
unset TF_WORKSPACE
export customer_root=$(pwd)
cd $customer_root
pwd
terraform fmt -recursive
```

### layer-00
* adjust CIDR in terraform.tfvars
* **NOTE**: IBP Root Module currently peers with management automatically.  Choose a unique CIDR Range.
```sh
code --goto "$customer_root/layer-00/terraform.tfvars:43"
code --goto "$customer_root/layer-00/terraform.tfvars:66"

# export flag="--auto-approve"
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
* `layer-02/terraform.tfvars` Adjustments
  * Update `EXAMPLE_FQDN` to match the backend PCA
  * Add Customer's EC2 Public key
  * Update `staging_sid` and `customer_number` as desired (see IBP Ansible Provisioning)
* `layer-02/instances.auto.tfvars` Adjustments
  * Add additional Virtual Machines if desired
  * Add Additional CNAMEs for Webdispatcher
  * Adjust Virtual Machine Sizes
```sh
code --goto "$customer_root/layer-02/terraform.tfvars:10:41"
code --goto "$customer_root/layer-02/terraform.tfvars:16:26"
code --goto "$customer_root/layer-02/terraform.tfvars:22:16"
code --goto "$customer_root/layer-02/instances.auto.tfvars:27:7"

# export flag="--auto-approve"
export flag=""
unset TF_WORKSPACE

cd $customer_root/layer-02
tfenv use min-required
terraform init
terraform apply $flag
```

## OPTIONAL Modules Below
### Bridge Network / layer-00
* Set the Customer Defined CIDR
```sh
code --goto "$customer_root/integrations/edge-vpc/layer-00/terraform.tfvars:9"

cd $customer_root/integrations/edge-vpc/layer-00; tfenv use min-required; terraform init
terraform apply $flag
```

### Bridge Network / layer-01
```sh
cd $customer_root/integrations/edge-vpc/layer-01; tfenv use min-required; terraform init
terraform apply $flag
```

### Layer-Options
This is a special template for optional Terraform layers.

The template provides output values from core terraform layers as metadata.  Custom code can be written and deployed in this layer.
Sovereign Cloud Single Tenant will only offer limited support for this layer.

### Layer-Options/ansible-inventory
* Copy the module files into "layer-options".
* Add your custom values into the auto.tfvars file.
* Terraform apply.

```sh
cd $customer_root/layer-options
cp ./ansible-inventory/* ./
code --goto "$customer_root/layer-options/ansible-inventory.auto.tfvars"
tfenv use min-required; terraform init
terraform apply $flag
```


## Terraform Destroy Order
```sh
# export flag="--auto-approve"
export flag=""
cd $customer_root/integrations/edge-vpc/layer-01; terraform destroy $flag
cd $customer_root/integrations/edge-vpc/layer-00; terraform destroy  $flag
cd $customer_root/layer-02; terraform destroy $flag
cd $customer_root/layer-01; terraform destroy $flag
cd $customer_root/layer-00; terraform destroy $flag
```
