/**
 Description: sample to use the module for hostname/endpoint scrapping
*/

locals {
  layer02_output_raw_list = {
    "s999app01tst" = {
      "cnames" = [
        "s999app01tst",
      ]
      "endpoint_port_list" = [
        "123",
        "456",
      ]
      "hostname"             = "scststapp"
      "instance_type"        = "t3.micro"
      "landscape"            = "Production"
      "name"                 = "app"
      "productgroup"         = "testgroup"
      "productname"          = "testproduct"
      "sid"                  = "tst"
      "tag_customdomain"     = "test.internal"
      "tag_customhostname"   = "scststapp"
      "tag_productcomponent" = "test_component"
    }
    "s999dbtst" = {
      "cnames" = [
        "s999dbtst",
      ]
      "hostname"             = "scststdb"
      "instance_type"        = "t3.micro"
      "landscape"            = "Production"
      "name"                 = "db"
      "productgroup"         = "s4hana"
      "productname"          = "s4hana"
      "sid"                  = "tst"
      "tag_customdomain"     = "test.internal"
      "tag_customhostname"   = "scststdb"
      "tag_productcomponent" = "test_component"
    }
  }
  edge_vpc_output_endpoint_list = {
    "s999app01tst" = {
      "endpoint" = {
        "dns_name" = tolist([
          "vpce-123-90hiq7zd.vpce-svc-456.region.vpce.amazonaws.com",
          "vpce-123-example-1b.vpce-svc-456.region.vpce.amazonaws.com",
          "vpce-123-example-1a.vpce-svc-456.region.vpce.amazonaws.com",
          "vpce-123-example-1c.vpce-svc-456.region.vpce.amazonaws.com",
        ])
        "id" = "vpce-123"
        "network_interface_ids" = toset([
          "eni-0876",
          "eni-0a04",
          "eni-0bbb",
        ])
      }
      "endpoint_service" = {
        "id"           = "vpce-svc-456"
        "service_name" = "com.amazonaws.vpce.region.vpce-svc-456"
      }
      "networkloadbalancer" = {
        "dns_name" = "s999app01tst-nlb-edge-99ab.elb.region.amazonaws.com"
        "id"       = "arn:aws-arn"
        "listeners" = {
          "123" = {
            "id" = "arn:aws-arn"
          }
          "456" = {
            "id" = "arn:aws-arn"
          }
        }
        "name" = "s999app01tst-nlb-edge"
        "targetgroups" = {
          "123" = {
            "id"   = "arn:arn:aws-arn"
            "name" = "s999app01tst-nlb-edge-123"
          }
          "456" = {
            "id"   = "arn:arn:aws-arn"
            "name" = "s999app01tst-nlb-edge-456"
          }
        }
      }
    }
  }
  customer_name = "test_customer"
}

module "processor" {
  source              = "../"
  customer_name       = local.customer_name
  generated_file_name = "${path.module}/pce-${local.customer_name}.txt"
  endpoint_list       = local.edge_vpc_output_endpoint_list
  raw_list            = local.layer02_output_raw_list
}
output "zzz_message" {
  value = "File output to ${path.module}/pce-${local.customer_name}.txt"
}
