# Terraform Contributing for Single Tenant Engineering
The following terraform standards are applied to achieve a scalable framework centering on a small core code but still maintaining flexibility through optional customizations and add-ons.  This code should be generally self-sufficient and document external dependencies where required.

## Terraform Terminology
The following is a subset of Terraform terminology commonly used. For an exhaustive list of terms, please follow Hashicorp guidelines.  [LINK](https://developer.hashicorp.com/terraform/docs/glossary)

* **Root Module** - Folder containing code where terraform begins code execution.
* **Child Module** - Folder containing code that is referenced from the Root Module.
* **Module** – Any folder containing terraform code.
* **Map** – a terraform data construct consisting of key-value pairs.
* **Human Use Tags** – Tags that are used for human readability and are not used for programmatic purposes.
* **Programmatic Tags** – Tags that are used for programmatically generated and are not used for human readability
* **Metadata** – Any logic construct of data used to pass information.
* **Resource** - A single (cloud) component that Terraform manages.

## Current Terraform Versions
The following table lists the terraform versions that all code should be pinned to.

* **NOTE** - At this time, this is recommended but not enforced.  Enforcement will be implemented in upcoming releases.

| Provider / Module | Version |
| --- | --- |
| Terraform | 1.5.7 |
| hashicorp/archive | 2.4.2 |
| hashicorp/aws | 5.49.0 |
| hashicorp/azuread | 2.53.1 |
| hashicorp/azurerm | 4.3.0 |
| hashicorp/external | 2.3.4 |
| hashicorp/http | 3.4.5 |
| hashicorp/local | 2.5.2 |
| hashicorp/null | 3.2.3 |
| hashicorp/random | 3.6.3 |
| hashicorp/template | 2.2.0 |
| hashicorp/time | 0.12.1 |
| hashicorp/tls | 4.0.5 |

## Terraform Standards
The following are enforced standards.

* Follow Terraform Best Practices where possible:
  * [LINK1](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)
  * [LINK2](https://developer.hashicorp.com/terraform/language/modules/develop/composition)
* Terraform Modules and code should be specifically written to Product Lines.
* Remote State Data reads should be restricted to root modules only.
* Tags and Tag Metadata should only be implemented and passed as Maps.
* Do not mix Human Use with Programmatic Tags and Metadata.
  * Resources Creation and Naming should use randomly generated ID only.
  * Do not use Human Use Tags and Metadata for Resource naming.
* All Resource creation should happen in Child Modules.
  * Root Modules should only be used to manipulate Metadata and call Child Modules.
  * Child Modules should receive their metadata via Variable inputs only. (No Terraform State Reads within the Child Module)
* Terraform Code should be located as described in [Terraform Layout](#terraform-layout).

## Terraform Changelogs
* A file `CHANGELOG-SCS.md` should be included. Use syntax prescribed in the General Contributing Guide.

## Terraform Best Practice
The following are general best practices to be enforced by Code Approvers. Deviations must be documented in code before approval in Merge Requests.

* Outputs should be structured in a way that matches the original provider as closely as possible.
* Minimize the number of required Input Variables as much as possible.
  * Include default values with Variables where possible.
  * Allow for customizations with advanced variables prefixed with “adv”
* Avoid nesting Child Modules.
* Add descriptions to your terraform outputs. (Used by Automatic Documentation)
* Use "Example Root" in Child Modules to provide validation and documentation.
* Avoid using `Random Keepers` without accompanying `Ignore Keepers`.
  * `Random Keepers` should be used sparingly and only in situations where you expect the `Random Resource` to frequently regenerate without human interaction and without impacting the "production up" state.
  * This Best Practice should also apply to similar scenarios such as `Time_Static Triggers`

## Terraform Linting
* Linting is enforced by Pre-Commit hooks and must pass the following rules:
    * No Symlinks
    * Check Json
    * Check Yaml
    * Check Toml
    * Trim Whitespace
    * Terraform Fmt

## Terraform Layout
This describes the root module layout of all Single Tenant Terraform Code

* Layer-NN (Numbered Layers)
  * Numbered Layers are reserved for and should only contain code critical to the solution.
    * Custom or Optional code should not be included here. Deviations should be documented in the code.
  * Layers are numbered in order of dependencies
  * Layer Outputs will be used via state files to other Root Modules.
* Layer-Options
  * General term referring to a root module implementing optional code.
  * The root module will provide Metadata from the numbered layers to be used by optional child modules.
  * Multiple "Options” Root modules may exist as needed but should provide the same base functionality of Metadata and Outputs.
    * Multiple "Options" modules may be desirable to break up execution time.
  * Each optional child module should be called with its own file that contains all necessary variable definitions and outputs along with the child calls.
  * TFVars can be merged into the main `terraform.tfvars` file, or be selfcontained in an `auto.tfvars` file.
  * Customized or Location Specific Code should only exist in Layer-Options
  * Globally provided Optional modules will be contained in a subfolder to be implemented as needed by moving relavent files back into the root.

* Layer-Integrations (Legacy)
  * This is a collection of legacy root modules. Most Notably Edge-VPC
  * Regional teams are encouraged to migrate away from these modules where possible.
