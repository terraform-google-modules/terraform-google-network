/*
  Description: Default values for Null Context
  Comments:
    - N/A
*/

locals {
  defaults = {
    basic_tags       = []
    custom_values    = {}
    delimiter        = "-"
    dependencies     = []
    deploy_prefix    = null
    generated_by     = "terraform"
    managed_by       = "terraform"
    name_prefix      = "~"
    replacement      = ""
    sentinel         = "~"
    short_max_length = 32

    customer     = "ns2"
    organization = "ns2"
    kv = {
      organization_friendly_name = "SAP National Security Services, Inc."
    }
    parent_domain_internal = "sapns2.internal"
    parent_domain_external = "sapns2.us"

    # DEFAULT FLAGS
    #  Flags should always default to false, only when the user sets it to true should it take a differnt action
    flags = {
      reset_module_values      = false
      reset_environment_values = false
      reset_custom_values      = false
      use_unique_name          = false
      use_org_prefix           = false
      skip_checks              = false
      override_name            = false
      name_from_resource       = false
      exclude_name_prefix      = false
      is_s3_bucket             = false
    }

    errors = {
      ERROR_RESOURCE_NAME_IS_TOO_LONG   = null
      MISSING_REQUIRED_TAG              = null
      ERROR_LESS_THAN_ONE_LABEL_ELEMENT = null
      MISSING_PARTITION                 = null
      MISSING_ACCOUNT_ID                = null
      MISSING_ACCOUNT_REGION            = null
    }

    label_order = ["security_boundary", "business", "customer"]

    # This would prefix label_order for unique naming. [prefix, label_order..., suffix]
    label_order_unique_prefix = ["organization"]
    # This would append to label_order for unique naming. [prefix, label_order..., suffix]
    label_order_unique_suffix = ["environment_salt"]
    environment_salt          = "~"

    regex_replace_chars_extended = "/[^\\w\\s\\d_.:/=+\\- @]/"

    values = {
      kv     = null
      locals = null
      tags   = null
    }

    resource_tags = [
      {
        name         = "BuildUser"
        value        = "build_user"
        required     = true
        pass_context = true
      },
      {
        name         = "ManagedBy"
        value        = "managed_by"
        required     = true
        pass_context = true
      },
      {
        name         = "GeneratedBy"
        value        = "generated_by"
        required     = true
        pass_context = true
      },
      {
        name         = "Business"
        value        = "business"
        required     = true
        pass_context = true
      },
      {
        name         = "Customer"
        value        = "customer"
        required     = true
        pass_context = true
      },
      {
        name         = "Environment"
        value        = "environment"
        required     = true
        pass_context = true
      },
      {
        name         = "TerraformModule"
        value        = "module"
        required     = false
        pass_context = true
      },
      {
        name         = "TerraformModuleVersion"
        value        = "module_version"
        required     = false
        pass_context = true
      },
      {
        name         = "TerraformParentModule"
        value        = "parent_module"
        required     = false
        pass_context = true
      },
      {
        name         = "TerraformParentModuleVersion"
        value        = "parent_module_version"
        required     = false
        pass_context = true
      },
      {
        name         = "TerraformRootModule"
        value        = "root_module"
        required     = false
        pass_context = true
      },
      {
        name         = "Owner"
        value        = "owner"
        required     = true
        pass_context = true
      },
      {
        name         = "ProvisionDate"
        value        = "provision_date"
        required     = true
        pass_context = false
      },
      {
        name         = "Name"
        value        = "resource_name"
        required     = false
        pass_context = false
      },
      {
        name         = "Image"
        value        = "vm_image"
        required     = false
        pass_context = false
      },
      {
        name         = "Description"
        value        = "description"
        required     = false
        pass_context = false
      },
      {
        name         = "SecurityBoundary"
        value        = "security_boundary"
        required     = true
        pass_context = true
      },
      {
        name         = "ScanGroup"
        value        = "vm_scan_group"
        required     = false
        pass_context = true
      },
      {
        name         = "Authorization"
        value        = "authorization"
        required     = false
        pass_context = true
      },
      {
        name         = "PatchGroup"
        value        = "vm_patch_group"
        required     = false
        pass_context = false
      },
      {
        name         = "Platform"
        value        = "vm_platform"
        required     = false
        pass_context = false
      },
      {
        name         = "ProductCluster"
        value        = "vm_product_cluster"
        required     = false
        pass_context = true
      },
      {
        name         = "ProductComponent"
        value        = "vm_product_component"
        required     = false
        pass_context = false
      },
      {
        name         = "ProductName"
        value        = "vm_product_name"
        required     = false
        pass_context = false
      },
      {
        name         = "ProductVendor"
        value        = "vm_product_vendor"
        required     = false
        pass_context = false
      },
      {
        name         = "ProductVersion"
        value        = "vm_product_version"
        required     = false
        pass_context = false
      },
      {
        name         = "Product"
        value        = "product"
        required     = false
        pass_context = false
      },
      {
        name         = "Organization"
        value        = "organization"
        required     = true
        pass_context = true
      },
      {
        name         = "TerraformDeploymentLayer"
        value        = "deployment_layer"
        required     = false
        pass_context = true
      },
      {
        name         = "TerraformWorkspace"
        value        = "workspace"
        required     = false
        pass_context = true
      }
    ]
  }
}
