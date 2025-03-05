Terraform-Null-Context
======================

> :warning: **NOTICE:** This module has been moved to https://gitlab.core.sapns2.us/scs/shared/terraform/terraform-null-context-legacy

This module is a module to create a context object that can be used by resources to determine naming, naming prefixing, tags, domain URL .
A context object can be passed into another creation of another context object. The goal of the context module is to be
able to make standardized naming and tagging of resources.

This module is using the standard naming format for terraform modules for the registry.

[[_TOC_]]

Features
--------

### Key / Value Storage

These KV stores are merged together before doing lookups for tags and labels.

- `local_kv`: This KV is not passed out in context, it is local to this resource.
- `environment_values.kv`: KV Store for environment values
- `module_values.kv`: KV Store for module values
- `custom_values.kv`: KV Store for custom values

**NOTE**: All KV stores are type `map(string)` to enable lookups for tags and labels

Example:
```hcl
module "base_s3_context" {
  source = "...../terraform-null-context"

  context     = module.base_context.context
  label_order = ["s3_prefix", "product", "customer", "s3_suffix"]
  custom_values = {
    tags    = null
    locals  = null
    kv = {
      s3_prefix = "my_s3"
      s3_suffix = "123456"
    }
  }
}

module "context_s3_binaries" {
  source = "...../terraform-null-context"

  context     = module.base_s3_context.context
  name        = "binaries"
  description = "S3 bucket for binary storage"
}

module "context_s3_images" {
  source = "...../terraform-null-context"

  context     = module.base_s3_context.context
  name        = "images"
  description = "S3 bucket for image storage"
}
```

### Tag Definitions

Tags can now be defined globally as well as at the environment level, module level and custom level.

Global tags use the structure:
```hcl
variable "resource_tags" {
  type = list(object({
    name = string
    value = string
    required = bool
    pass_context = bool
  }))
}
```

- `name`: Display value of the tag
- `value`: variable name to look up in the KV store
- `required`: is this tag required? Checks will fail if marked as required and not populated.
- `pass_context`: If set to true, this tag and the value of it is the same for all resources, otherwise the tag is unique to the resource. Example of a unique tag is resource name.

**NOTE**: `environment_values`, `module_values`, `custom_values` tags do not include the `pass_context` as they are going to be all unique for the resource.

#### Automatic Tags

If there is a key in any of the KV Stores that matches `<TAG NAME>_friendly_name` then a auto tag will be created with the key `<TAG NAME>-Name` and a value of the value in the KV Store.

#### Additional Tags

If you would like to include additional tags in your context object you can set the `additional_tags` input with the
tags you would like to use. Additional tags will be merged with the tags that are automatically generated.

```hcl
module "context" {
  source = "./"

  business      = "ns2"
  customer      = "aaa"
  build_user    = "c5309336"
  owner         = "c5309336"

  additional_tags = {
    MyOtherTag = "TagValue"
  }
}
```

### Variable & Context Storage

The Context module contains 3 different context/variable storage containers. These containers are intended to be used at different levels as they are named:
- `environment_values`
    - For use at the environment level (account level).
    - By default, will get merged together with inherited `environment_values` from parent context
    - Must pass `reset_environment_values` in order to ensure parent values are reset and not inherited
- `module_values`
    - For use at the module level.
    - This gets reset when a new module name is passed in.
- `custom_values`
    - This is intended to be used if the other two containers are not enough.

The structure of these containers is as so:
```hcl
variable "environment_values" {
  type = object({
    kv = map(string)
    tags = list(object({
      name = string
      value = string
      required = bool
    }))
    locals = any
})
}
```

- `kv` is a key/value store that are passed between context modules in the environment.
- `tags` is a list of tag definitions that are passed between context modules in the environment.
- `locals` is an any type object to store any other custom values needed for the environment.

### Flags

There are now different flags that can be set, by default all flags are `false`. Flags are never passed out via context

Supported Flags:
- `reset_module_values`: Reset `modules_values`
- `reset_environment_values`: Resets `environment_values`, will no longer merge with parent context
- `reset_custom_values`: Reset `custom_values`
- `use_unique_name`: Use a unique name for this resource
- `use_org_prefix`: Use the org name as a prefix for the resource name
- `skip_checks`: Skip checks for for required tags and other required values
- `override_name`: Override the name with the name provided
- `name_from_resource`: Parse the name from an existing resource name


### Module Tracking

There is automatic module tracking. When you create a new context resource and pass in `module` and `module_version` into the context, a tag for each is automatically created. If the output context is passed into another module, `module` and `module_version` are moved to `parent_module` and `parent_module_version` and will not be overwritten anymore. This is to be able to track the module and the parent module that are responsible for deploying that resource.


### Context & Tagging

Context & Tagging is the main functionality of the context module.

I recommend creating a base context object in your `main.tf` file that can be used as a baseline for tagging and resource
prefixing. This base context object can then be passed into new context objects if you would like to use the context
module for naming of resources.

#### Example Base Context
This would go in `main.tf`
```hcl
module "context" {
  source = "./"

  business      = "ns2"
  customer      = "aaa"
  build_user    = "c5309336"
  owner         = "c5309336"
}
```

This module will produce this output:
```hcl
output = {
  "base_tags" = {
    "BuildUser"     = "c5309336"
    "Business"      = "ns2"
    "Customer"      = "aaa"
    "Owner"         = "c5309336"
    "ProvisionDate" = "2020-07-09T20:18:51Z"
  }
  "build_user" = "c5309336"
  "business"   = "ns2"
  "context" = {
    "build_user"    = "c5309336"
    "business"      = "ns2"
    "customer"      = "aaa"
    "delimiter"     = "-"
    "deploy_prefix" = "tf-deploy"
    "label_order" = [
      "business",
      "customer",
      "environment",
    ]
    "owner"               = "c5309336"
    "provision_date"      = "2020-07-09T20:18:51Z"
    "regex_replace_chars" = "/[^a-zA-Z0-9-]/"
  }
  "customer"      = "aaa"
  "delimiter"     = "-"
  "label_order" = [
    "business",
    "customer",
    "environment",
  ]
  "owner"               = "c5309336"
  "provision_date"      = "2020-07-09T20:18:51Z"
  "regex_replace_chars" = "/[^a-zA-Z0-9-]/"
  "resource_label_attributes" = [
    "tf-deploy",
    "ns2",
    "aaa",
  ]
  "resource_prefix" = "tf-deploy-ns2-aaa"
  "tags" = {
    "BuildUser"     = "c5309336"
    "Business"      = "ns2"
    "Customer"      = "aaa"
    "DeployTag"     = "tf-deploy"
    "Owner"         = "c5309336"
    "ProvisionDate" = "2020-07-09T20:18:51Z"
  }
}
```

These outputs can be used for different resources, for example:

```hcl
resource "aws_lambda_function" "example_function" {
  function_name = "${module.contex.resource_prefix}-example-function"
  description   = "Example lambda function for context module example."
  ...
  ...

  tags = merge(module.contex.tags, {
    Name        = "${module.contex.resource_prefix}-example-function"
    Description = "Example lambda function for context module example."
  })
}
```

This will create a lambda function with the name `tf-deploy-ns2-aaa-example-function` with the tags:
```hcl
{
    "BuildUser"     = "c5309336"
    "Business"      = "ns2"
    "Customer"      = "aaa"
    "DeployTag"     = "tf-deploy"
    "Owner"         = "c5309336"
    "ProvisionDate" = "2020-07-09T20:18:51Z"
    "Name"          = "tf-deploy-ns2-aaa-example-function"
    "Description"   = "Example lambda function for context module example."
}
```

#### Disambiguation in a single module that may be instantiated multiple times

For example in your main.tf in your top-level environment you might have
something like the following:

```hcl
module "base_context" {
  source = "./"

  business      = "ns2"
  customer      = "aaa"
  build_user    = "c5309336"
  owner         = "c5309336"
}

This then includes a module that may be instantiated multiple times which
requirs a name to be passed to it (for example, a nat gateway module that
configures a nat gateway for multiple different subnets):

```hcl
module "nat_gateway_01" {
  source = "../nat-gateway"

  name = "natgw-01"
  context = module.base_context.context
}

module "nat_gateway_02" {
  source = "../nat-gateway"

  name = "natgw-02"
  context = module.base_context.context
}
```

Inside the `nat-gateway` module the following would be used, it passes in a
`name_prefix` so that all null contexts that reference that will automatically
generate names that contains it:


```hcl

module "module_context" {
  source = "./"

  name_prefix = var.name
}

module "resource" {
  source = "./"

  context = module.module_context.context
  name = "example-function"
}
```

And within the module instantation with name `natgw-01` it would create the
following name:

```
module.resource.name == tf-deploy-ns2-aaa-natgw-01-example-function
```

and in the module instantiation with name `natgw-02` it would create the
following name:

```
module.resource.name == tf-deploy-ns2-aaa-natgw-02-example-function
```



### Context & Tagging + Naming

In the example above you had to use the context `resource_prefix` and add the name of the function to it as well. This
could be simplified by creating a new context for the lambda function using the base context (`module.context`) as an
input.

```hcl
module "example_function_context" {
  source = "./"

  # This is using `module.context` from `main.tf` as shown above
  context     = module.context.context
  name        = "example-function"
  description = "Example lambda function for context module example."
}

resource "aws_lambda_function" "example_function" {
  function_name = module.example_function_context.name
  description   = module.example_function_context.description
  ...
  ...

  tags = module.example_function_context.tags
}
```

This will also create a lambda function with the name `tf-deploy-ns2-aaa-example-function` with the tags:
```hcl
{
    "BuildUser"     = "c5309336"
    "Business"      = "ns2"
    "Customer"      = "aaa"
    "DeployTag"     = "tf-deploy"
    "Owner"         = "c5309336"
    "ProvisionDate" = "2020-07-09T20:18:51Z"
    "Name"          = "tf-deploy-ns2-aaa-example-function"
    "Description"   = "Example lambda function for context module example."
}
```

#### _Note_

`name` and `description` are not passed out of the module with the `context` output. This means that you can use a named
context object as an input into another new context object. The output `base_tags` also do not include the `Name` or
`Description` tags. However, it does include the the `additional_tags`


Inputs
======

Required (Also used for tagging)
--------------------------------

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `partition` | `string` | The current account ID | N/A |
| `account_id` | `string` | The current account ID | N/A |
| `region` | `string` | The deployment region | N/A |
| `build_user` | `string` | The user deploying terraform | N/A |
| `managed_by` | `string` | How this deployment is managed | `terraform` |
| `generated_by` | `string` | How this deployment is generated | `terraform` |
| `business` | `string` | Business, a way to identify the org that the resource belongs to | N/A |
| `customer` | `string` | Customer, who is this resource for | `ns2` |
| `environment` |  `string` | Environment, e.g. 'prod', 'staging', 'dev', 'build' | N/A |
| `environment_salt` | `string` | Random hex to put after resource names. Ideally substr(sha256(account_id), 0, 6) | N/A |
| `owner` | `string` | Who is responsible for this resource | N/A |
| `security_boundary` | `string` | Security Boundary, What is the security boundary for this resource? `prod/cre/fedciv` | N/A |
| `organization` | `string` | What is the organization responsible for this | `ns2` |
| `delimiter` | `string` | Delimiter for naming and labeling | `-` |
| `label_order` | `list(string)` | Order to put labels in | `["security_boundary", "business", "customer"]` |
| `regex_replace_chars` | `string` | Regex to apply to labels | `"/[^a-zA-Z0-9-]/"` |
| `include_customer_label` | `bool` | include the customer label in the resource name | `false` |

Optional
--------

**NOTE**: `(KV)` Means that this is used as a tag and the value is looked up in the KV Store

| Name | Type | Description |
|------|------|-------------|
| `module` | `string` | What module was this deployed with |
| `module_version` | `string` | What was the module version this was deployed with |
| `name` | `string` | The name to give to the resource |
| `description` | `string` | The description of the resource |
| `name_prefix` | `string` | A label to put after the naming prefix but before the resource name |
| `additional_tags` | `map(string)` | Additional tags to add to the resource |
| `authorization` (KV) | `string` | Authorization for the change |
| `vm_scan_group` (KV) | `string` | What scan group to put the resource in |
| `vm_patch_group` (KV) | `string` | What patch group to put the resource in |
| `vm_product_cluster` (KV) | `string` | What is the product cluster of the instance |
| `vm_product_component` (KV) | `string` | What is the product component of this resource |
| `vm_product_name` (KV) | `string` | What is the product name of this instrance |
| `vm_product_vendor` (KV) | `string` | What is the product vendor |
| `vm_product_version` (KV) | `string` | Version of the product |
| `deployment_layer` (KV) | `string` | What deployment layer is this deployed in |
| `workspace` (KV) | `string` | What workspace was this deployed in |


Highlighted Outputs
===================

### prefix_label_mapping

expresses the various tiers of name prefixing with both formatted and/or friendly versions

#### Example 1

Inputs:
```
label_order = ["security_boundary","business"]
security_boundary = {
  name     = "cre", formatted = "CRE"
  friendly = "Commercial Regulated Environment"
}
business = {
  name     = "sms", formatted = "SMS"
  friendly = "Shared Management Services"
}
```

Produces:
```
  + prefix_label_mapping = {
      + bottom    = {
          + formatted = "CRE SMS"
          + friendly  = "Commercial Regulated Environment Shared Management Services"
          + name      = "cre sms"
        }
      + formatted = {
          + business          = "CRE SMS"
          + security_boundary = "CRE"
        }
      + friendly  = {
          + business          = "Commercial Regulated Environment Shared Management Services"
          + security_boundary = "Commercial Regulated Environment"
        }
      + name      = {
          + business          = "cre sms"
          + security_boundary = "cre"
        }
      + prefix    = {
          + business          = "cre-sms"
          + security_boundary = "cre"
        }
    }
```

#### Example 2

Inputs:
```
label_order = ["security_boundary","business","minor_security_boundary"]
security_boundary = {
  name     = "cre", formatted = "CRE"
  friendly = "Commercial Regulated Environment"
}
business = {
  name     = "s4", formatted = "S4"
  friendly = "S4 Hana"
}
minor_security_boundary = {
  name     = "pce", formatted = "PCE"
  friendly = "Private Cloud Edition"
}
```

Produces:
```
  + prefix_label_mapping = {
      + bottom    = {
          + formatted = "CRE S4 PCE"
          + friendly  = "Commercial Regulated Environment S4 Hana Private Cloud Edition"
          + name      = "cre s4 pce"
        }
      + formatted = {
          + business          = "CRE S4"
          + security_boundary = "CRE"
          + minor_security_boundary      = "CRE S4 PCE"
        }
      + friendly  = {
          + business          = "Commercial Regulated Environment S4 Hana"
          + security_boundary = "Commercial Regulated Environment"
          + minor_security_boundary      = "Commercial Regulated Environment S4 Hana Private Cloud Edition"
        }
      + name      = {
          + business          = "cre s4"
          + security_boundary = "cre"
          + minor_security_boundary      = "cre s4 pce"
        }
      + prefix    = {
          + business          = "cre-s4"
          + security_boundary = "cre"
          + minor_security_boundary      = "cre-s4-pce"
        }
    }
```

#### Example 3

Inputs:
```
label_order = ["security_boundary","business","minor_security_boundary","account_identifier"]
security_boundary = {
  name     = "aus", formatted = "AUS"
  friendly = "Australia"
}
business = {
  name     = "scp", formatted = "SCP"
  friendly = "SAP Cloud Platform"
}
minor_security_boundary = {
  name     = "preprod", formatted = "PreProd"
  friendly = "Pre-Production"
}
account_identifier = {
  name     = "cf", formatted = "CF"
  friendly = "Cloud Foundry"
}
```

Produces:
```
  + prefix_label_mapping = {
      + bottom    = {
          + formatted = "AUS SCP PreProd CF"
          + friendly  = "Australia SAP Cloud Platform Pre-Production Cloud Foundry"
          + name      = "aus scp preprod cf"
        }
      + formatted = {
          + account_identifier = "AUS SCP PreProd CF"
          + business           = "AUS SCP"
          + security_boundary  = "AUS"
          + minor_security_boundary       = "AUS SCP PreProd"
        }
      + friendly  = {
          + account_identifier = "Australia SAP Cloud Platform Pre-Production Cloud Foundry"
          + business           = "Australia SAP Cloud Platform"
          + security_boundary  = "Australia"
          + minor_security_boundary       = "Australia SAP Cloud Platform Pre-Production"
        }
      + name      = {
          + account_identifier = "aus scp preprod cf"
          + business           = "aus scp"
          + security_boundary  = "aus"
          + minor_security_boundary       = "aus scp preprod"
        }
      + prefix    = {
          + account_identifier = "aus-scp-preprod-cf"
          + business           = "aus-scp"
          + security_boundary  = "aus"
          + minor_security_boundary       = "aus-scp-preprod"
        }
    }
```

### domain

expresses the various calculated tiers of DNS domain-naming based on the configured label order

#### Example 1

Inputs:
```
label_order = ["security_boundary","business"]
security_boundary = {
  name     = "cre", formatted = "CRE"
  friendly = "Commercial Regulated Environment"
}
business = {
  name     = "sms", formatted = "SMS"
  friendly = "Shared Management Services"
}
```

Produces:
```
  + domain = {
      + external        = "sms.cre.sapns2.us"
      + internal        = "sms.cre.sapns2.internal"
      + label_mapping   = {
          + external = {
              + business          = "sms.cre.sapns2.us"
              + security_boundary = "cre.sapns2.us"
            }
          + internal = {
              + business          = "sms.cre.sapns2.internal"
              + security_boundary = "cre.sapns2.internal"
            }
        }
      + parent_external = "sapns2.us"
      + parent_internal = "sapns2.internal"
    }
```

#### Example 2

Inputs:
```
label_order = ["security_boundary","business"]
parent_domain_internal = "sapns2.mil"
parent_domain_external = "sapns2.mil"
security_boundary = {
  name     = "dod1", formatted = "DoD1"
  friendly = "Department of Defense 1"
}
business = {
  name     = "btp", formatted = "BTP"
  friendly = "Business Technology Platform"
}
```

Produces:
```
  + domain = {
      + external        = "btp.dod1.sapns2.mil"
      + internal        = "btp.dod1.sapns2.mil"
      + label_mapping   = {
          + external = {
              + business          = "btp.dod1.sapns2.mil"
              + security_boundary = "dod1.sapns2.mil"
            }
          + internal = {
              + business          = "btp.dod1.sapns2.mil"
              + security_boundary = "dod1.sapns2.mil"
            }
        }
      + parent_external = "sapns2.mil"
      + parent_internal = "sapns2.mil"
    }
```

#### Example 3

Inputs:
```
label_order = ["security_boundary","business","minor_security_boundary","account_identifier"]
security_boundary = {
  name     = "aus", formatted = "AUS"
  friendly = "Australia"
}
business = {
  name     = "scp", formatted = "SCP"
  friendly = "SAP Cloud Platform"
}
minor_security_boundary = {
  name     = "preprod", formatted = "PreProd"
  friendly = "Pre-Production"
}
account_identifier = {
  name     = "cf", formatted = "CF"
  friendly = "Cloud Foundry"
}
```

Produces:
```
  + domain = {
      + external        = "cf.preprod.scp.aus.sapns2.us"
      + internal        = "cf.preprod.scp.aus.sapns2.internal"
      + label_mapping   = {
          + external = {
              + account_identifier = "cf.preprod.scp.aus.sapns2.us"
              + business           = "scp.aus.sapns2.us"
              + security_boundary  = "aus.sapns2.us"
              + minor_security_boundary       = "preprod.scp.aus.sapns2.us"
            }
          + internal = {
              + account_identifier = "cf.preprod.scp.aus.sapns2.internal"
              + business           = "scp.aus.sapns2.internal"
              + security_boundary  = "aus.sapns2.internal"
              + minor_security_boundary       = "preprod.scp.aus.sapns2.internal"
            }
        }
      + parent_external = "sapns2.us"
      + parent_internal = "sapns2.internal"
    }
```

Using Context
=============

The easiest way to get context into your module is to make a file called `context.tf` in the directory with your module with the following contents. Doing this allows us to update all modules in our terraform codebase with automation if we ever need to make changes to inputs in the context module.

```hcl
variable "context" {
  type = object({
    account_id             = string
    additional_tags        = map(string)
    build_user             = string
    business               = string
    customer               = string
    delimiter              = string
    environment            = string
    environment_salt       = string
    generated_by           = string
    include_customer_label = bool
    label_order            = list(string)
    managed_by             = string
    module                 = string
    module_version         = string
    name_prefix            = string
    organization           = string
    owner                  = string
    parent_module          = string
    parent_module_version  = string
    regex_replace_chars    = string
    region                 = string
    root_module            = string
    security_boundary      = string

    custom_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    environment_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    module_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    resource_tags = list(
      object({
        name         = string
        value        = string
        required     = bool
        pass_context = bool
      })
    )

  })
  default = {
    account_id             = null
    additional_tags        = null
    build_user             = null
    business               = null
    custom_values          = null
    customer               = null
    delimiter              = null
    environment            = null
    environment_salt       = null
    environment_values     = null
    generated_by           = null
    include_customer_label = null
    label_order            = null
    managed_by             = null
    module                 = null
    module_values          = null
    module_version         = null
    name_prefix            = null
    organization           = null
    owner                  = null
    parent_module          = null
    parent_module_version  = null
    regex_replace_chars    = null
    region                 = null
    resource_tags          = null
    root_module            = null
    security_boundary      = null
  }
}
```
