/*
  Description: TFVars file for AWS QTM Module.
  Notes: Add this to your layer-options compatible root module to deploy AWS QTM in PCE
*/

# Basic Example given.  See AWS-QTM Module TF Docs for full options.
qtm_vm_values = {
  qtm_database = {
    instance_type = "t3.micro" # `r5.8xlarge` is considered default for SAP
    meta_key_name = "dbqt"
  }
  qtm_application = {
    instance_type = "t3.micro" # `m5.xlarge` is considered default for SAP
    meta_key_name = "app01qta"
  }
  qtm_webdispatcher = {
    instance_type = "t3.micro" # `m5.large` is considered default for SAP
    meta_key_name = "app01ww1"
  }
}

qtm_certificate_arn = "arn:___EXAMPLE_CERTIFICATE_ARN___"
