/*
    Filename: route53.tf
    Synopsis: Creates Route53 DNS record associates it with the AWS Instance
    Input Triggers:
        - associate_route53_private_ip_address: Boolean value, a value of true
          will trigger this file.
    Description: When triggered, this file will create and associate Route53
                 DNS records to the Instance IPs.
    Comments:
        - This assumes a private zone and no public DNS records being created.
        - The variables also assume a default A record and TTL of 5 minutes being created.
        - If an A record is created, an AAAA record will also be created for
          those instances that have IPv6 addresses
*/

resource "aws_route53_record" "instance_a_record" {
  zone_id = var.route53_zoneid
  count   = var.route53_associate_private_ip_address == true ? 1 : 0
  name    = aws_instance.instance.id
  ttl     = var.route53_ttl
  type    = "A"
  records = [aws_instance.instance.private_ip]
}

resource "aws_route53_record" "instance_aaaa_record" {
  zone_id = var.route53_zoneid
  count   = var.route53_associate_private_ip_address == true && coalesce(var.ipv6_address_count, 0) >= 1 ? 1 : 0
  name    = aws_instance.instance.id
  ttl     = var.route53_ttl
  type    = "AAAA"
  records = aws_instance.instance.ipv6_addresses
}

locals {
  instance_id_trimmed = trimprefix(aws_instance.instance.id, "i-")

  tag_productname          = lookup(aws_instance.instance.tags, "ProductName", "")
  tag_productcluster       = lookup(aws_instance.instance.tags, "ProductCluster", "")
  tag_productcomponent     = lookup(aws_instance.instance.tags, "ProductComponent", "")
  instance_cname_simple    = "${local.tag_productname}-${local.instance_id_trimmed}"
  instance_cname_cluster   = local.tag_productcluster != "" ? "${local.tag_productcluster}-${local.instance_cname_simple}" : ""
  instance_cname_component = local.tag_productcomponent != "" ? "${local.tag_productcomponent}-${local.instance_cname_simple}" : ""
  instance_cname_both      = local.tag_productcluster != "" && local.tag_productcomponent != "" ? "${local.tag_productcomponent}-${local.tag_productcluster}-${local.instance_cname_simple}" : ""
  instance_cname           = local.instance_cname_both != "" ? local.instance_cname_both : (local.instance_cname_component != "" ? local.instance_cname_component : (local.instance_cname_cluster != "" ? local.instance_cname_cluster : local.instance_cname_simple))
}

resource "aws_route53_record" "instance_cname" {
  zone_id = var.route53_zoneid
  count   = ((var.route53_associate_private_ip_address == true) && (var.route53_associate_cname == true)) ? 1 : 0
  name    = local.instance_cname
  ttl     = var.route53_ttl
  type    = "CNAME"
  records = [aws_route53_record.instance_a_record[0].fqdn]
}

resource "aws_route53_record" "instance_additional_cname" {
  zone_id = var.route53_zoneid
  count   = (var.route53_associate_private_ip_address == true) ? length(var.route53_additional_cnames) : 0
  name    = var.route53_additional_cnames[count.index]
  ttl     = var.route53_ttl
  type    = "CNAME"
  records = [aws_route53_record.instance_a_record[0].fqdn]
}

data "aws_route53_zone" "instance" {
  count   = var.route53_zoneid != "" ? 1 : 0
  zone_id = var.route53_zoneid
}
