/*
  Description: Terraform input variables
*/

variable "command" {
  description = "Command to run on the Terraform controller"
  type        = string
}

variable "shell_type" {
  description = "The type of shell to run the command in on the Terraform controller (e.g. bash, zsh)"
  type        = string
  default     = "bash"

  validation {
    condition     = var.shell_type == "bash"
    error_message = "The shell_type current only supports 'bash'."
  }
}
