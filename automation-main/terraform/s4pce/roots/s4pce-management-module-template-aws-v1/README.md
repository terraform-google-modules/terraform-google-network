# s4pce-management-module-template-aws-v1
This is a management network with workspaces for Sovereign Cloud S4/HANA Private Cloud Edition environments.

This terraform code can be used with the replacement of certain Example values as outlined below.

## NOTE on Workspaces and multi-region deployments
There should be a primary region selected which will house all terraform states while using terraform workspaces to deploy management networks in different regions.
There are some terraform layers which deploy multi-region resources and should only be deployed once in the primary region.  This includes:
* `init` - This terraform layer deploys IAM users and Authoritative Route53 zones. Which should not be duplicated across regions.
* `integrations/sms/layer-00` - This generates the metada for the SMS service and should only be deployed once in the primary region.


## NOTE on missing Management Componentes and Features
To standardize our management network, we had to remove several deployment specific features found in previously deployed management networks. Some of the  automation code has be preserved in `_opt_` folders.  Most notable omissions include:
* `init/_opt_sms-security` - Contains configurations that are now enforced by SMS. Includes IAM Policies, Groups, and MFA requirements.
* `layer-01/_opt_tenable` - Specific Tenable configurations only deployed in certain environments.
* `splunk on call` - This code has been omitted as it was only deployed in certain environments.
* `cross-cloud code`
* `Certificates`
* `backint`
* `lambda functions`

## NOTE Addition to Management Network
This template introduces terraform for aws_route53_vpc_association_authorization that was not present in the original code. This non-destructive change that codifies existing configuration deployed by null resources using existing variables.

## NOTE on templates folder
This terraform module has forked the original shared templates repository. It has been included to reduce cross-repository dependencies.

## Terraform Layers
| Layer Name | Description |
| ---------- | ----------- |
| init | This layer creates initial metadata and some multi-region resources that cannot be deployed via workspaces. |
| layer-00 | This layer creates the critical infrastructure in each region. |
| layer-01 | This layer create additional policies and services in each region. |
| layer-02 | This layer deploys compute resources in each region. |
| integrations/sms | This layer generates metadata necessary for SMS integrations. |
| integrations/gardener/shoot-vpc/layer-00 | This layer generates a separate VPC for the Gardener Shoot Cluster |
| integrations/gardener/shoot-vpc/layer-01 | This layer updates the management route table with Gardner controlled routes |

## Template Variables
The Following variables should be replaced with deployment specific values.

| Variable Name | Description |
| ------------- | ----------- |
| EXAMPLE_SOURCE | Relative path to the terraform source module repository.
| EXAMPLE_STATE_REGION | Primary AWS Region of the management network
| EXAMPLE_BUCKET | Terraform state bucket.  Should be in the Primary AWS Region
| EXAMPLE_DYNAMODB | DynamoDB Table for Terraform state locking.  Should be in the Primary AWS Region
| EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME | Tagging Value
| EXAMPLE_SECURITY_BOUNDARY | Tagging Value, used in name generation
| EXAMPLE_ENVIRONMENT | Tagging Value, used in name generation
| EXAMPLE_ORGANIZATION_FRIENDLY_NAME | Tagging Value
| EXAMPLE_ORGANIZATION | Tagging Value, used in name generation
| EXAMPLE_OWNER_EMAIL |  Tagging Value
| EXAMPLE_MANAGEMENT_KEY | Management Key Value, typically "management". Can be used for testing alternate management deployments
| EXAMPLE_INTERNAL_FQDN | Internal FQDN for the management network.  Workspace/Region Specific.
| EXAMPLE_SNS_TOPIC | SNS Name. See Variable files for more details.
| EXAMPLE_TOPIC_NAME | SNS Topic Name. See Variable files for more details.
| EXAMPLE_SNS_EMAIL | SNS Email. See Variable files for more details.
| EXAMPLE_ACM_PCA_ARN | ACM PCA ARN. This value should be retrieved from SMS deployments.
| EXAMPLE_TESTING_UNIQUE_ | Unique Identifier for testing.  Should be kept under 10 characters

## Example Use cases
### Search and Replace Values
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
```sh
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_STATE_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_DYNAMODB/ibp-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../../automation|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.internal/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/test-management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_INTERNAL_FQDN/test-fqdn.internal/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_TESTING_UNIQUE_/test-/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SNS_TOPIC/s4pce-dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_TOPIC_NAME/s4pce-dev-monitoring/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SNS_EMAIL/example@noreply.internal/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_ACM_PCA_ARN|RETRIEVE FROM SMS INTERMEDIATE PCA DEPLOYMENTS|g' {} \;
terraform fmt -recursive
```


### Run Terraform
Complete the following steps and run Terraform.

#### Prep
Set the following values for your local terraform environment.
```sh
# Navigate to root folder
flag=""
unset TF_WORKSPACE
export path_root=$(pwd)
# validate path
cd $path_root
pwd
```

#### init layer
This layer creates initial metadata and some multi-region resources that cannot be deployed via workspaces.
* Authoritative Route53 zone
* SES Configuration for mail relays.
* Cloudwatch Configuration.
```sh
# flag="--auto-approve"
flag=""

code --goto "$path_root/init/terraform.tfvars:8:15"
# Set dns_external_fqdn to create your authoritative FQDN. (Only possible in Commercial Regions)
# Set ses_identity_domain to use FQDN if not created above.
# Set other variables as needed
unset TF_WORKSPACE
cd $path_root/init
tfenv use min-required
terraform init
#
terraform apply $flag
```


#### layer-00
For Each Workspace
* adjust management CIDR ensuring there is no overlap with other networks.
* adjust the tenant CIDR ensuring there is no overlap with other networks.
* adjust the aws_region
* Validate other variables
```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")

for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  code --goto "$path_root/layer-00/workspace-tfvars/$TF_WORKSPACE.tfvars:12:15"
done
# adjust region
# adjust cidr
# Set the internal FQDN
# validate other variables.
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/layer-00;
  tfenv use min-required
  terraform init
  # If terraform prompts, select "default"
  terraform apply -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
```


#### layer-01
Run Terraform for each Workspace
```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")

for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  code --goto "$path_root/layer-01/workspace-tfvars/$TF_WORKSPACE.tfvars:8:15"
done
#
# Adjust the region in the workspace.tfvars file
#
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/layer-01;
  tfenv use min-required
  terraform init
  terraform apply -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
```


#### layer-02
* Add SSH Public Key to `terraform.tfvars`
```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")

for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  code --goto "$path_root/layer-02/workspace-tfvars/$TF_WORKSPACE.tfvars:8:15"
done
code --goto "$path_root/layer-02/terraform.tfvars:13:30"
#
# Update regions
# Add your public key
# backup_metadata = { selection_name = test }   # Use this if your names are especially long (testing)
#
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/layer-02;
  tfenv use min-required
  terraform init
  terraform apply -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
```



#### integrations/sms
This will generate metadata necessary for SMS integrations
```sh
unset TF_WORKSPACE
code --goto "$path_root/integrations/sms/layer-00/terraform.tfvars:2"
cd $path_root/integrations/sms/layer-00
tfenv use min-required
terraform init
terraform apply $flag
```

#### integrations/gardener/shoot-vpc/layer-00
This will create gardener shoot vpcs in each region.
```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")

# Gardener Shoot VPC CIDR Ranges are allowed to overlap as traffic is not expected to transit outside the regional network.
# Otherwise adjust CIDR Ranges as desired.
#
# The Gardener VPC will use two CIDR Ranges.  The primary CIDR will be dedicated to Gardener to manage.  The secondary CIDR will be used for add on subnets such as RDS and Private Link deployments.
# Default Gardener CIDR Range is a CIDR /16.  The default secondary CIDR Range is a /20.
#
# An example VPC domain name is provided, this should uncommented and modified as needed if the example value is not sufficient for the environment.
# Improper configuration of this value can cause failure to deploy Gardener clusters to this Shoot VPC!
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  code --goto "$path_root/integrations/gardener/shoot-vpc/layer-00/workspace-tfvars/$TF_WORKSPACE.tfvars:8:15"
done

###
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/integrations/gardener/shoot-vpc/layer-00;
  tfenv use min-required
  terraform init
  terraform apply -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
```

#### integrations/gardener/shoot-vpc/layer-01
This layer is used to update the route tables with gardner managed routes.  This should be run occasionally after gardner has completed initial provisioning.
```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")

# Update the Gardener Project and Shoot Cluster Names
code --goto "$path_root/integrations/gardener/shoot-vpc/layer-01/terraform.tfvars:10:32"
###
###
###
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/integrations/gardener/shoot-vpc/layer-01;
  tfenv use min-required
  terraform init
  terraform apply -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
```


#### Maintenance
For each customer added/removed.  Repeat the integrations/sms steps.



#### Deletion
Use the following to destroy the management network.

```sh
# flag="--auto-approve"
flag=""
workspaces=("east" "west")
unset TF_WORKSPACE
cd $path_root/integrations/sms/layer-00; terraform destroy $flag
for workspace in ${workspaces[@]}; do
  export TF_WORKSPACE=$workspace
  cd $path_root/integrations/gardener/shoot-vpc/layer-01; terraform destroy -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
  cd $path_root/integrations/gardener/shoot-vpc/layer-00; terraform destroy -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
  cd $path_root/layer-02; terraform destroy -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
  cd $path_root/layer-01; terraform destroy -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
  cd $path_root/layer-00; terraform destroy -var-file workspace-tfvars/$TF_WORKSPACE.tfvars $flag
done
unset TF_WORKSPACE
  cd $path_root/init; terraform destroy $flag
```
