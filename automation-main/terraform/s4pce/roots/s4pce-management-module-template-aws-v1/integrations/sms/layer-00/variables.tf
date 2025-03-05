/*
  Description: Terraform Inputs
  Comments: N/A
*/

variable "customer_list" {
  description = "List of customers to add to the USC Network Integration"
  type        = list(string)
}
