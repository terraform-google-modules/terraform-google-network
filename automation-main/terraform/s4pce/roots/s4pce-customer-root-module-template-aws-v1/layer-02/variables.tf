/*
  Description: Terraform input variables
  Layer: 02
*/

##### AWS Variables
variable "aws_region" {
  description = "AWS Region"
}
variable "build_user" {
  description = "User id of individual executing terraform; must be defined for auditing purposes."
}

##### SAP Router Variables
variable "saprouter_ingress_cidr" {
  description = "Allowed Ingress for SAP Router"
  type        = list(string)
  default     = ["194.39.131.34/32"]
}

##### Instance Variables
variable "image_database_name" {
  description = "Search string for Database image"
  type        = string
}
variable "image_application_name" {
  description = "Search string for SAP Application image"
  type        = string
}
variable "ssh_main01_public_key" {
  description = "SSH public key to create an AWS EC2 Key from and associate with management instances"
}
variable "git_name" {
  description = "Git username to download repositories; define if performing bootstrap through userdata."
}
variable "git_token" {
  description = "Git token to download repositories; define if performing bootstrap through userdata."
}
variable "ami_owner_default" {
  description = "Default AMI Owner to use"
  default     = "156506675147"
}
variable "instance_list" {
  description = "A map of instances to create"
  type        = any
  default     = null
  #Example:
  // instance_list = {
  //   instance01 = {
  //     os          = "rhel"                             # Optional Defaults to rhel. Used to determine patch group.  Options are: [rhel, ubuntu, windows]
  //     sid         = "n01"                              # Required.  SID of the Instance
  //     name        = "hana"                             # Used for tagging.  Typically: [hana, app, webdispatcher, cloudconnector]
  //     hostname    = "alternate-hostname"               # Optional.  If not specified the key will be used as the hostname
  //     productname = "s4"                               # Product Tagging.  Examples: [s4, bw4, ads]
  //     description = "Test Instance"
  //     landscape   = "Quality-Assurance"                # Used to determine subnet. Options are: [Production, Quality-Assurance, Development]
  //     az             = "1a"                            # Optional. Do not include to use predetermined AZ based on landscape.
  //     ami            = "Golden-SHC-RHEL-8.1-HANA-V*"   # Optional. If not declared, will use "hana" or "app" AMI based off the name above.
  //     ami_owner      = "156506675147"                  # Optional. Do not include to use default owner
  //     instance_type  = "t3.micro"
  //     securitygroups = []                              # Optional. Used to apply additional Security groups on top of the defaults
  //     cnames         = []                              # Optional.
  //   }
  // }
}

##### HA Instances List
variable "ha_instances" {
  description = "Used to disable source/destination checking on HA instances"
  type        = list(string)
  default     = []
}

###### AWS S3 Bucket Variables
variable "create_bucket" {
  description = "Controls the creation of the backup S3 Bucket"
  type        = bool
  default     = false
}

variable "bucket_retention_days" {
  description = "Specifies how long objects should be retained before expiration or automatically deleted for the additional backup S3 bucket"
  default     = "180"
}


variable "noncurrent_version_expiration" {
  description = "Defines a period after which noncurrent versions of objects are automatically deleted for the additional backup S3 bucket"
  default     = "180"
}

variable "noncurrent_version_transition_days" {
  description = "Specifies the number of days after which noncurrent versions of objects are transitioned to a different storage class for the additional backup S3 bucket"
  default     = "30"
}

#### Disabling/Enabling Backup Plan Variable
variable "enable_backup" {
  type    = number
  default = 1
}