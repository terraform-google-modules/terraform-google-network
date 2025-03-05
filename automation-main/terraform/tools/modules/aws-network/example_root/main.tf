/*
  Description: Create basic requirements for testing.
  Comments: Uncomment and add public key to deploy 2 instances for testing.
*/


# resource "aws_key_pair" "example_key" {
#   key_name   = "example_key"
#   public_key = ""
# }

# resource "aws_instance" "example" {
#   ami           = "ami-0083ec3d351a43930"
#   instance_type = "t3.micro"
#   subnet_id     = module.module_test.subnets["10.108.0.0/24"].id
#   vpc_security_group_ids = [
#     module.module_test.security_groups.base_egress.id,
#     module.module_test.security_groups.base_ingress.id
#   ]
#   associate_public_ip_address = false
#   ipv6_address_count          = 1
#   key_name                    = aws_key_pair.example_key.key_name
# }
# resource "aws_instance" "example2" {
#   ami           = "ami-0083ec3d351a43930"
#   instance_type = "t3.micro"
#   subnet_id     = module.module_test.subnets["10.108.2.0/26"].id
#   vpc_security_group_ids = [
#     module.module_test.security_groups.base_egress.id,
#     module.module_test.security_groups.base_ingress.id
#   ]
#   associate_public_ip_address = true
#   ipv6_address_count          = 1
#   key_name                    = aws_key_pair.example_key.key_name
# }
# output "zzz_instance" { value = {
#   private_ip = aws_instance.example.private_ip
#   public_dns = aws_instance.example.public_dns
#   public_ip  = aws_instance.example.public_ip
#   ipv6       = aws_instance.example.ipv6_addresses
# } }
# output "zzz_instance2" { value = {
#   private_ip = aws_instance.example2.private_ip
#   public_dns = aws_instance.example2.public_dns
#   public_ip  = aws_instance.example2.public_ip
#   ipv6       = aws_instance.example2.ipv6_addresses
# } }
# data "http" "my_ip" {
#   url = "https://checkip.amazonaws.com"
# }
# resource "aws_vpc_security_group_ingress_rule" "my_ip_ingress" {
#   security_group_id = module.module_test.security_groups.base_ingress.id
#   ip_protocol       = "-1"
#   cidr_ipv4         = "${chomp(data.http.my_ip.response_body)}/32"
# }
