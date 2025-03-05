/*
  Description: Main module logic
*/

### External Script Execution
data "external" "script" {
  program = ["bash", "${path.module}/files/${var.shell_type}/run-command.sh"]

  query = {
    command = var.command
  }
}

locals {
  error  = data.external.script.result.stderr
  result = data.external.script.result.stdout
}
