s4pce-customer-root-module-template-azure
===========================================

This is a generic terraform customer template for Sovereign Cloud S4/HANA Private Cloud Edition.

This terraform code can be used with the replacement of certain Example values as outlined below.

## Template Variables
The Following variables should be replaced with deployment specific values.

| Variable Name | Description |
| ------------- | ----------- |
| EXAMPLE_SOURCE | Relative path to the terraform source module repository.
| #EXAMPLE_BACKEND_environment | Line for the Backend configuration Environment
| #EXAMPLE_BACKEND_subscription_id | Line for the Backend configuration Subscription ID
| #EXAMPLE_BACKEND_resource_group_name | Line for the Backend configuration Resource Group Name
| #EXAMPLE_BACKEND_storage_account_name | Line for the Backend configuration Storage Account Name
| #EXAMPLE_BACKEND_container_name | Line for the Backend configuration Container Name
| #EXAMPLE_BACKEND_key | Line for the Backend configuration Key
| EXAMPLE_AWS_REGION | AWS Region Value
| EXAMPLE_AWS_BUCKET | AWS Bucket Value
| EXAMPLE_AWS_ACCOUNT_ID | AWS Account ID Value
| EXAMPLE_DYNAMODB | AWS DynamoDB Table Value
| EXAMPLE_AZURE_ENVIRONMENT | Azure Environment Value
| EXAMPLE_SUBSCRIPTION_ID | Subscription ID Value
| EXAMPLE_RESOURCE_GROUP_NAME | Resource Group Name Value
| EXAMPLE_STORAGE_ACCOUNT_NAME | Storage Account Name Value
| EXAMPLE_CONTAINER_NAME | Container Name Value
| EXAMPLE0001 | Customer Identifier
| EXAMPLE_REGION | Region Value
| EXAMPLE_CLOUD_PARTITION_FRIENDLY_NAME | Tagging Value
| EXAMPLE_CLOUD | Tagging Value
| EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME | Tagging Value
| EXAMPLE_SECURITY_BOUNDARY | Tagging Value, used in name generation
| EXAMPLE_ENVIRONMENT | Tagging Value, used in name generation
| EXAMPLE_ORGANIZATION_FRIENDLY_NAME | Tagging Value
| EXAMPLE_ORGANIZATION | Tagging Value, used in name generation
| EXAMPLE_OWNER_EMAIL |  Tagging Value
| EXAMPLE_IMAGE_RESOURCE_GROUP_NAME | Image Resource Group Name Value
| EXAMPLE_SPLUNK_URL | Splunk URL Value
| E001 | Customer Key Identifier
| EXAMPLE_MANAGEMENT_KEY | Management Key Value, used for testing alternate management deployments

## Example Use cases
### Method1 Search and Replace
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
```sh
find ./ -type f -exec sed -i '' -e 's/#EXAMPLE_BACKEND_//g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_ACCOUNT_ID/677692745833/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_DYNAMODB/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AZURE_ENVIRONMENT/usgovernment/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SUBSCRIPTION_ID/ec477f00-3632-495f-8a99-3ad5568024d8/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_RESOURCE_GROUP_NAME/dev-s4-pce-management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_STORAGE_ACCOUNT_NAME/scsdevs4pce/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CONTAINER_NAME/scs-dev-s4-pce-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../..|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_REGION/USGov Virginia/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CLOUD_PARTITION_FRIENDLY_NAME/Government/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CLOUD/gov/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.com/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_IMAGE_RESOURCE_GROUP_NAME/build-images-usgovvirginia-3ad5568024d8/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SPLUNK_URL|about:blank|g' {} \;
find ./ -type f -exec sed -i '' -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
terraform fmt --recursive

```
* Follow SOP for terraform deployment.


### Method2 Search and Replace + backend.tfvar
* Copy the template to desired location.
* Update values to desired
* Search and Replace Values
```sh
find ./ -type f -exec sed -i '' -e 's/#EXAMPLE_BACKEND_//g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_REGION/us-gov-west-1/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_BUCKET/ibp-development-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AWS_ACCOUNT_ID/677692745833/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_AZURE_ENVIRONMENT/usgovernment/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SUBSCRIPTION_ID/ec477f00-3632-495f-8a99-3ad5568024d8/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_RESOURCE_GROUP_NAME/dev-s4-pce-management/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_STORAGE_ACCOUNT_NAME/scsdevs4pce/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CONTAINER_NAME/scs-dev-s4-pce-terraform/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE0001/support0001/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SOURCE|../..|g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_REGION/USGov Virginia/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CLOUD_PARTITION_FRIENDLY_NAME/Government/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_CLOUD/gov/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME/Development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_SECURITY_BOUNDARY/dev/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ENVIRONMENT/development/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION_FRIENDLY_NAME/SAP Sovereign Cloud Services/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_ORGANIZATION/scs/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_OWNER_EMAIL/build@sapscs.com/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_IMAGE_RESOURCE_GROUP_NAME/build-images-usgovvirginia-3ad5568024d8/g' {} \;
find ./ -type f -exec sed -i '' -e 's|EXAMPLE_SPLUNK_URL|about:blank|g' {} \;
find ./ -type f -exec sed -i '' -e 's/E001/s001/g' {} \;
find ./ -type f -exec sed -i '' -e 's/EXAMPLE_MANAGEMENT_KEY/management/g' {} \;
terraform fmt --recursive

```
* Follow SOP for `backend.tfvar` terraform deployment
