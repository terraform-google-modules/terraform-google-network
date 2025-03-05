Terraform External Run Command
==============================

> :warning: **NOTICE:** This module has been moved to https://gitlab.core.sapns2.us/scs/shared/terraform/terraform-external-run-command

This module provides the ability to run any command in a specified shell on the Terraform controller. This command will execute during the plan stage of execution.

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Terraform v0.13+
* jq
* openssl

Example Usage
-------------

```hcl
module "run_command_curl_webpage" {
  source  = "<path>/<to>/ns2-terraform/modules/terraform-external-run-command"

  command = "curl https://www.example.com"
}

output "example_curl_webpage_response" {
  value = module.run_command_curl_webpage.result
}
```

Argument Reference
------------------

* `command` - Command to run on the Terraform controller
* `shell_type` - (defaults to `bash`) The type of shell to run the command in on the Terraform controller
  * `bash` - Command will be executed in a [bash](https://www.gnu.org/software/bash/) shell

Attributes Reference
--------------------

* `error` -  The error message returned in the event of an unsuccessful execution. Will return an empty string (`""`) if no errors occur.
* `result` - The returned results from the executed command. Will return an empty string (`""`) in the event of an error.

Author Information
------------------

* Devon Thyne [devon.thyne@sapns2.com](mailto:devon.thyne@sapns2.com)
