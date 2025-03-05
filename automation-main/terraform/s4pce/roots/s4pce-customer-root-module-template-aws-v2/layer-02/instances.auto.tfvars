/*
  Description: Terraform instance_list input
  Comments:
*/

instance_list = {
  E001dbhp4 = {
    sid                  = "HP4"
    name                 = "DB"
    productname          = "S4Hana"
    productgroup         = "Enterprise Management"
    tag_productcomponent = "testing"
    landscape            = "Production"
    instance_type        = "r5.8xlarge"
    cnames               = ["E001dbhp4"]
  }
  E001dbhp4ha = {
    sid                  = "HP4"
    name                 = "DB"
    productname          = "S4Hana"
    productgroup         = "Enterprise Management"
    tag_productcomponent = "testing"
    landscape            = "Production"
    instance_type        = "r5.8xlarge"
    cnames               = ["E001dbhp4ha"]
    az                   = "1b"
  }
  E001app01ps4 = {
    sid                  = "PS4"
    name                 = "App"
    productname          = "S4Hana"
    productgroup         = "Enterprise Management"
    tag_productcomponent = "testing"
    landscape            = "Production"
    instance_type        = "m5.4xlarge"
    cnames               = ["E001app01ps4"]
    endpoint_port_list   = ["3601", "3200", "3298", "3300", "4800", "8000", "8001", "44300", "50001"]
  }
  E001cs01ps4 = {
    sid                  = "PS4"
    name                 = "App"
    productname          = "Central_Service"
    productgroup         = "Central Services"
    tag_productcomponent = "testing"
    landscape            = "Production"
    instance_type        = "t3a.micro"
  }
  E001cs02ps4 = {
    sid                  = "PS4"
    name                 = "App"
    productname          = "Central_Service"
    productgroup         = "Central Services"
    tag_productcomponent = "testing"
    landscape            = "Production"
    instance_type        = "t3a.micro"
  }
}
