/*
  Description: Output variables of the aws-endpoint-services modules
  Comments: N/A
*/


output "base_context" { value = module.base_context.context }
output "service_network" {
  value = module.service_network
}
output "consumer_network" {
  value = module.consumer_network
}


output "test_privatekey" {
  value     = tls_private_key.keygen.private_key_pem
  sensitive = true
}
output "test_publickey" { value = aws_key_pair.key_pair.public_key }
output "test_instance" { value = aws_instance.service_instance.id }
