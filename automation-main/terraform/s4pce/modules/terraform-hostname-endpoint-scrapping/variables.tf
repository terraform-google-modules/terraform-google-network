/*
  Description: input variables
*/
variable "generated_file_name" {
  description = "name for the generated file"
  type        = string
  default     = "./pce.txt"
}

variable "customer_name" {
  description = "customer name"
  type        = string
}

#output from edge vpc layer
variable "endpoint_list" {
  description = "endpoint list from edge vpc"
  type        = map(any)
}

#output from layer2 with instance info
variable "raw_list" {
  description = "raw instance list from infrastructure layer"
  type        = any
}
