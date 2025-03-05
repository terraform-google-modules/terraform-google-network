// /*
//   Description: Outputs from the layer-00 module; Contains commonly used outputs needed by other modules and dependent automation
//   Layer: 00
//   Comments: N/A
// */



##### Metadata variables

### Gateway
output "internet_gateway_main01" { value = { id = aws_internet_gateway.main01.id } }

### Instances
output "instance_openvpn" { value = module.instance_openvpn }

### KeyPairs
output "key_pair_main01" { value = {
  key_name = aws_key_pair.main01.key_name
  id       = aws_key_pair.main01.id
} }

### Routes
### Security Groups
output "security_group_main01_vpn_ingress" { value = {
  id   = aws_security_group.main01_vpn_ingress.id
  name = aws_security_group.main01_vpn_ingress.tags.Name
} }
