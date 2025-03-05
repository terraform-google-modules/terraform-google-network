variable "toplevelzone_fqdn" {
  description = "The top-level DNS zone under which all customers' DNS steering zone are to housed."
  type        = string
}

variable "toplevelzone_id" {
  description = "The top-level DNS zone under which all customers' DNS steering zone are to housed."
  type        = string
}

variable "customer_id" {
  description = "The internal customer ID string to setup DNS steering for."
  type        = string
}

variable "endpoints" {
  description = "The records to be created under the customer zone, such that the key is the zone record (FOO for FOO.customer.toplevel) and the value is the target of the CNAME."
  type        = map(string)
}

variable "vpc_id" {
  description = "(optional) when using a private zone, you must provide a VPC ID."
  type        = string
  default     = ""
}
