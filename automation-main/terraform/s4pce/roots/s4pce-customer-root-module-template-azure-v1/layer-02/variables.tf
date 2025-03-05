/*
  Description: Terraform input variables
*/

variable "windows_admin_password" {
  description = "Temporary password to deploy new windows VMs"
  type        = string
  default     = ""
}

variable "default_subnet" {
  description = "The default subnet to place quality_assurance and development into if not explicit"
  type        = string
  default     = "nonproduction"
}

variable "instance_list" {
  description = "A map of instances to create"
  type        = any
  default     = null
  # Example:
  // instance_list = {
  //   instance01 = {
  //     os             = "rhel"                        # Optional Defaults to rhel. Used to determine patch group.  Options are: [rhel, ubuntu, windows]
  //     sid            = "n01"                         # Required.  SID of the Instance
  //     name           = "hana"                        # Used for tagging.  Typically: [hana, app, webdispatcher, cloudconnector]
  //     hostname       = "alternate-hostname"          # Optional.  If not specified the key will be used as the hostname
  //     productname    = "s4"                          # Product Tagging.  Examples: [s4, bw4, ads]
  //     description    = "Test Instance"               # Used for tagging.
  //     landscape      = "Quality-Assurance"           # Used to determine subnet. Options are: [Production, Quality-Assurance, Development]
  //     az             = "1"                           # Optional. Do not include to use predetermined AZ based on landscape.
  //     image          = "Golden-SHC-RHEL-8.1-HANA-V*" # Optional. If not declared, will use "hana" or "app" AMI based off the name above.
  //     instance_type  = "Standard_DS1_v2"             # Virtual Machine size.
  //     securitygroups = []                            # Optional. Used to apply additional Application Security groups on top of the defaults
  //     cnames         = []                            # Optional.
  //     subnet         = ""                            # Optional. String used to override the subnet placement translated from landscape
  //   }
  // }
}


variable "image_database_name" {
  description = "Search string for Database image"
  type        = string
}

variable "image_application_name" {
  description = "Search string for SAP Application image"
  type        = string
}

##### SAP Router Variables
variable "saprouter_ingress_cidr" {
  description = "Allowed Ingress for SAP Router"
  type        = list(string)
  default     = ["194.39.131.34/32"]
}
