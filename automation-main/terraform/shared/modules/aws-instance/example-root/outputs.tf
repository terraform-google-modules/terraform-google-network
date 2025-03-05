/*
  Description: Outputs of the module; Commonly used values of the module
  Comments:
    - Each module call should match one or more outputs listed here.
*/

output "EXAMPLE_01_INSTANCE_WITH_ONLY_REQUIRED_OPTIONS" {
  value = module.EXAMPLE_01_INSTANCE_WITH_ONLY_REQUIRED_OPTIONS
}

output "EXAMPLE_02_INSTANCE_WITH_FULL_OPTIONS" {
  value = module.EXAMPLE_02_INSTANCE_WITH_FULL_OPTIONS
}

output "EXAMPLE_O3_WITH_NULL_CONTEXT" {
  value = module.EXAMPLE_O3_WITH_NULL_CONTEXT
}

output "EXAMPLE_O4_WITH_NULL_CONTEXT_AND_LEGACY_TAGS" {
  value = module.EXAMPLE_O4_WITH_NULL_CONTEXT_AND_LEGACY_TAGS
}


output "test_privatekey" {
  value = tls_private_key.keygen.private_key_pem
}

output "test_publickey" {
  value = aws_key_pair.key_pair.public_key
}
