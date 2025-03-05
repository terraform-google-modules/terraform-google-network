/*
  Description: Output file of the module; Outputs commonly used values from the module.
  Comments:
*/

output "name" { value = aws_instance.instance.tags.Name }
output "instance_id" { value = aws_instance.instance.id }
output "public_ip" { value = try(aws_eip_association.instance[0].public_ip, aws_instance.instance.public_ip) }
output "private_ip" { value = aws_instance.instance.private_ip }
output "subnet_id" { value = aws_instance.instance.subnet_id }
output "ipv6_addresses" { value = aws_instance.instance.ipv6_addresses }
output "availability_zone" { value = aws_instance.instance.availability_zone }
output "cname" { value = ((var.route53_associate_private_ip_address == true) && (var.route53_associate_cname == true)) ? aws_route53_record.instance_cname[0].fqdn : "" }
output "additional_cnames" { value = length(data.aws_route53_zone.instance) >= 1 ? formatlist("%s.%s", var.route53_additional_cnames, trimsuffix(data.aws_route53_zone.instance[0].name, ".")) : null }
output "instance_arn" { value = aws_instance.instance.arn }
