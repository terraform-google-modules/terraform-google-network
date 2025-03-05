##
| Record                | DNS Steering |
| --------------------- | ------------ |
%{ for key, value in endpoints ~}
|  ${key}            | ${value.fqdn}  |
%{ endfor ~}
