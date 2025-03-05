/*
  Description: IBP Instances
  Comment:
    - This is a default configuration. Customize to Customer Spec
    - metadata_keys reflect legacy hardcoded values. Keep this for now, as not all code has been updated for dynamic values.
    - NOTE: Remember to fill out the additional webdispatcher CNAMEs
*/

instance_map = {
  E001cpids = {
    metadata_key    = "instance_cpids"
    image_type      = "database"
    subnet_lookup   = "dataservices_1"
    tag_name        = "cpids"
    tag_description = "EXAMPLE0001 CPI-DS"
    instance_type   = "r5.xlarge" # This value should not change.
    cnames          = ["E001-cpids"]
  }
  E001wdisp = {
    metadata_key    = "instance_webdispatcher"
    image_type      = "application"
    subnet_lookup   = "dataservices_1"
    tag_name        = "webdispatcher"
    tag_description = "EXAMPLE0001 Webdispatcher"
    instance_type   = "m5.xlarge" # This value should not change.
    cnames = [
      # "wdisp-n99",
      "E001-wdisp",
    ]
  }
  E001dbstag = {
    metadata_key    = "instance_staging_ibpdb"
    image_type      = "database"
    subnet_lookup   = "staging_1"
    tag_name        = "hana"
    tag_description = "EXAMPLE0001 Staging IBP DB"
    instance_type   = "EXAMPLE_r5.4xlarge" # This value should be set by Customer Contract
    cnames          = ["E001-ibpdb-stg"]
  }
  E001appstag = {
    metadata_key    = "instance_staging_ibpapp"
    image_type      = "application"
    subnet_lookup   = "staging_1"
    tag_name        = "ibpapp"
    tag_description = "EXAMPLE0001 Staging IBP APP"
    instance_type   = "EXAMPLE_m5.2xlarge" # This value should be set by Customer Contract
    cnames          = ["E001-ibpapp-stg"]
  }
  E001dbprod = {
    metadata_key    = "instance_production_ibpdb"
    image_type      = "database"
    subnet_lookup   = "production_1"
    tag_name        = "hana"
    tag_description = "EXAMPLE0001 Production IBP DB"
    instance_type   = "EXAMPLE_r5.4xlarge" # This value should be set by Customer Contract
    cnames          = ["E001-ibpdb-prd"]
  }
  E001appprod = {
    metadata_key    = "instance_production_ibpapp"
    image_type      = "application"
    subnet_lookup   = "production_1"
    tag_name        = "ibpapp"
    tag_description = "EXAMPLE0001 Production IBP APP"
    instance_type   = "EXAMPLE_m5.2xlarge" # This value should be set by Customer Contract
    cnames          = ["E001-ibpapp-prd"]
  }
}
