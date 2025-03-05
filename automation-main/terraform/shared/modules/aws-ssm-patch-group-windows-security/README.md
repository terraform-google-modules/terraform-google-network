aws-ssm-baseline-windows-security
=================================

This module creates custom AWS SSM Patch Baselines for Windows systems on demand. Baseline applies only `security` patches.

Dependencies
------------

* Terraform 0.12
* AWS Administrator level privileges or privileges to manage SSM

Implementation of aws-ssm-baseline-windows-security Module
----------------------------------------------------------

Please see the README.md file underneath the `example_root` folder for correct implementation steps.

**DO NOT Run the terraform directly from this module folder**

Module Variables
----------------

### approved_patches

A list of explicitly approved patches for the baseline. These patches will marked as approved without delay automatically by a patch scan regardless of how the patch filters are set up.

For Windows operating systems, specify patches using Microsoft Knowledge Base IDs and Microsoft Security Bulletin IDs:

Example:
```
...
  approved_patches = [
    "KB2032276",
    "MS10-048"
  ]
...
```

For more information, please reference the AWS SSM Documentation [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html).

### rejected_patches

A list of explicitly rejected patches for the baseline. These patches will always be ignored and remain untouched by SSM regardless of the patch filters defined.

For Windows operating systems, specify patches using Microsoft Knowledge Base IDs and Microsoft Security Bulletin IDs:

Example:
```
...
  rejected_patches = [
    "KB2032276",
    "MS10-048"
  ]
...
```

For more information, please reference the AWS SSM Documentation [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html).

### windows_versions

A list of Windows versions to approve patches for. Please note that by default the selection is defaulted to support `All` versions. If desired, the user may define a targeted subset of available versions to override this default.
```
windows_versions = [
  "Windows10",
  "Windows10LTSB",
  "Windows7",
  "Windows8",
  "Windows8.1",
  "Windows8Embedded",
  "WindowsServer2008",
  "WindowsServer2008R2",
  "WindowsServer2012",
  "WindowsServer2012R2",
  "WindowsServer2016",
  "WindowsServer2019",
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
