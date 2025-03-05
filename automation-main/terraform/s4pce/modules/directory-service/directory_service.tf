/*
  Description: Creates Directory Service (Microsoft AD) in AWS
  Comments:
*/

locals {
  ds_subnets = length(var.directory_service_subnets.import_subnet_ids) != 0 ? var.directory_service_subnets.import_subnet_ids : [
    for key, value in aws_subnet.main01 : value.id
  ]
}
resource "aws_directory_service_directory" "main01" {
  name        = var.directory_service.fqdn
  short_name  = var.directory_service.netbios
  password    = var.directory_service.admin_password
  edition     = var.adv_directory_service_edition
  type        = "MicrosoftAD"
  description = var.adv_directory_service_description
  tags        = var.tags
  vpc_settings {
    vpc_id     = var.directory_service_vpc_id
    subnet_ids = local.ds_subnets
  }
  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "aws_ssm_document" "ssm_domain_join_doc" {
  name          = "AwsDomainJoin-${aws_directory_service_directory.main01.name}"
  document_type = "Command"
  content = <<DOC
  ${jsonencode({
  "schemaVersion" : "2.2",
  "description" : "Automatic Domain Join Configuration",
  "mainSteps" : [
    {
      "action" : "aws:domainJoin",
      "name" : "DomainJoin",
      "inputs" : {
        "directoryId" : "${aws_directory_service_directory.main01.id}",
        "directoryName" : "${aws_directory_service_directory.main01.name}",
        "dnsIpAddresses" : "${aws_directory_service_directory.main01.dns_ip_addresses}"
      }
    }
  ]
})}
  DOC
tags = merge(local.tags, {
  meta_name = "AwsDomainJoin-${aws_directory_service_directory.main01.name}"
})
}


output "directory_service" { value = {
  dns_ip_addresses      = aws_directory_service_directory.main01.dns_ip_addresses
  id                    = aws_directory_service_directory.main01.id
  ds_subnets            = local.ds_subnets
  fqdn                  = aws_directory_service_directory.main01.name
  ssm_domain_joiner_doc = aws_ssm_document.ssm_domain_join_doc.name
} }
