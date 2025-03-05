/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments: N/A
*/


##### Gardener Variables
variable "gardener_project_name" {
  description = "Name of the Gardener project in which the shoot cluster is managed"
  type        = string
}
variable "gardener_shoot_cluster_name" {
  description = "Name of the Gardener shoot cluster that is deployed to the VPC created in layer-00 of this integration"
  type        = string
}
