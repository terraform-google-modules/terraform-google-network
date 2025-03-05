/*
  Description: ssh key for VM access.
  Comment:
*/
resource "tls_private_key" "testkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "vm_pem" {
  content         = tls_private_key.testkey.private_key_pem
  filename        = "${path.root}/.ssh/pkey.pem"
  file_permission = "0400"
}

resource "local_sensitive_file" "vm_public_pem" {
  content         = tls_private_key.testkey.public_key_pem
  filename        = "${path.root}/.ssh/public_key.pem"
  file_permission = "0400"
}
