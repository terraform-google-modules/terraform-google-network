/*
Description: Terraform input variables
*/

### Hidden Advanced Variables
# These variables are not intended to be modified
# but provide advanced configuration options
# or compensate lack of feature parity.
# Limited support is provided for these variables, use at your own risk.

variable "adv_soft_delete" {
  type        = bool
  description = "(Optional) Enables soft delete for the Recovery Services Vaults"
  default     = true
}
