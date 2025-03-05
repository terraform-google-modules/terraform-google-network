aws-ssm-baseline-ubuntu-security
================================

This module creates custom AWS SSM Patch Baselines for Ubuntu systems on demand. Baseline applies `security` patches only.

Implementation of aws-ssm-baseline-ubuntu-security Module
---------------------------------------------------------

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage VPC, EC2, EIPs and related services
* AWS S3 buckets to store the terraform state files

Module Variables
----------------

### approved_patches

A list of explicitly approved patches for the baseline. These patches will marked as approved without delay automatically by a patch scan regardless of how the patch filters are set up.

Example:
```
...
  approved_patches = [
    "example-pkg-0.710.10-2.7.abcd.x86_64",
    "example-pkg-*.abcd.x86_64"
  ]
...
```

For more information, please reference the AWS SSM Documentation [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html).

### rejected_patches

A list of explicitly rejected patches for the baseline. These patches will always be ignored and remain untouched by SSM regardless of the patch filters defined.

Example:
```
...
  rejected_patches = [
    "example-pkg-0.710.10-2.7.abcd.x86_64",
    "example-pkg-*.abcd.x86_64"
  ]
...
```

For more information, please reference the AWS SSM Documentation [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html).

### ubuntu_versions

A list of Ubuntu versions to approve patches for. Please note that by default the selection is defaulted to support `All` versions. If desired, the user may define a targeted subset of available versions to override this default.
```
ubuntu_versions = [
  "Ubuntu14.04",
  "Ubuntu16.04",
  "Ubuntu18.04",
  "Ubuntu20.04",
  "Ubuntu20.10",
  ...
]
```

For reference for an up-to-date list of available versions, please see AWS docs for [Patch Manager prerequisites](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-prerequisites.html)

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module
to create a dependency.  Leave this variable blank to run immediately.

Author Information
------------------

* Devon Thyne (devon.thyne@sapns2.com)
