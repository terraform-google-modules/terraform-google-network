/*
  Description: Output variables of the aws-endpoint-services modules
  Comments: N/A
*/

output "endpoint_80_results" { value = module.endpoint_test_80 }
output "endpoint_443_results" { value = module.endpoint_test_443 }
output "test_privatekey" {
  value     = tls_private_key.keygen.private_key_pem
  sensitive = true
}
output "test_publickey" { value = aws_key_pair.key_pair.public_key }
