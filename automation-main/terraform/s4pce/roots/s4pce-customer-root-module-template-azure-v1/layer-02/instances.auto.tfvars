/*
  Description: Terraform instance_list input
  Comments:
*/

instance_list = {
  E001dbhp4 = {
    sid                  = "HP4"
    name                 = "db"
    productname          = "S4Hana"
    productgroup         = "Enterprise Management"
    landscape            = "Production"
    instance_type        = "Standard_M32ls"
    cnames               = ["E001dbhp4"]
    tag_customdomain     = "sapscs.internal"
    tag_customhostname   = "scshp4db"
    tag_productcomponent = "testing"
    hostname             = "scshp4db"
  }
  E001app01ps4 = {
    sid                      = "PS4"
    name                     = "app"
    productname              = "S4Hana"
    productgroup             = "Enterprise Management"
    landscape                = "Production"
    instance_type            = "Standard_D16ds_v4"
    cnames                   = ["E001app01ps4"]
    tag_customdomain         = "sapscs.internal"
    tag_customhostname       = "scsps4app"
    tag_productcomponent     = "testing"
    hostname                 = "scsps4app"
    endpoint_port_list       = ["3601", "3200", "3298", "3300", "4800", "8000", "8001", "44300", "50001"]
    spr_interfaces_efs_mount = "interface-prd"
  }

}
