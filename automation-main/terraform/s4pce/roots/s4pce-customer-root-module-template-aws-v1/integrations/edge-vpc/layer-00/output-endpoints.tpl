##
| Record                | Endpoint DNS |
| --------------------- | ---- |
%{ for key, value in endpoint_list ~}
|  ${key}            | ${value.endpoint.dns_name[0]}  |
%{ endfor ~}
%{ for key, value in sftp_list ~}
|  ${key}            | ${value.endpoint.0.dns_name[0]}  |
%{ endfor ~}
%{ for key, value in nlb_list ~}
|  ${key}            | ${value.dns_name}  |
%{ endfor ~}
