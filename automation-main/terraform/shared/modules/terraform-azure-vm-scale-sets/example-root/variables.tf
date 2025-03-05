/*
  Description: Variables used by the module to create network load balancers, and private endpoints and VM scaleset.
  Comments:
*/

variable "build_user" {
  description = "(Required) UserId to create the stack."
  type        = string
}
