/*
  Description: Templated, Optional Terraform input variables with default values
*/

### User Variables
variable "git_name" {
  description = "(Optional) When bootstrap `true` selected for instance module(s), git username to download repositories with"
  type        = string
  default     = ""
}
variable "git_token" {
  description = "(Optional) When bootstrap `true` selected for instance module(s), git token to download repositories"
  type        = string
  default     = ""
}
