/*
  Description: Terraform input variables
  Comments:
    Requires null context
*/

##### Router Variables
variable "router_asn" {
  description = "ASN number for the customer router BGP configuration"
  type        = string
}

##### VPC Variables
variable "gcn_management" {
  description = "Management GCN outputs"
}
variable "gcn_cidr_block" {
  description = "Customer GCN CIDR block"
}

##### Subnet Variables
variable "subnets" {
  description = "Dictionary of subnets to be created"
}
variable "health_check_ip_source" {
  #NOTE: https://cloud.google.com/load-balancing/docs/health-check-concepts?&_ga=2.88374875.-1170855520.1643042064#ip-ranges
  description = "Source IP from Google for Load Balancer Heatlh Checks"
  type        = list(string)
  default = [
    "35.191.0.0/16",
    "130.211.0.0/22",
    "209.85.152.0/22",
    "209.85.204.0/22",
    "169.254.169.254/32",
  ]
}

variable "cloud_functions_bucket" {
  description = "GCS bucket source for cloud functions"
  type        = string
}
variable "cloud_function_fsbackup_source" {
  description = "Path to fsbackup.zip cloud function code"
  type        = string
}

##### Size to provision filestore in gigabytes
variable "filestore_size" {
  description = "Size of filestore to be provisioned"
  type        = string
  default     = 1024
}

#### GCS variables
variable "versioning" {
  description = "Whether or not versioning is enabled for GCS bucket"
  type        = bool
  default     = false
}

#### Lifecycle policy variables in days for GCP Cloud Storage
variable "tier_to_archive_days" {
  description = "Tier to archive after days since modification greater than"
  type        = number
  default     = 30
}

variable "delete_after_days" {
  description = "Delete after days since modification greater than"
  type        = number
  default     = 180
}

#### VPC flow logs variables for subnets
variable "log_aggregation_interval" {
  description = "Flow log aggregation interval"
  type        = string
  default     = "INTERVAL_5_SEC"
}

variable "log_flow_sampling" {
  description = "Flow log sampling rate"
  type        = number
  default     = 0.5
}
