## ${customer_name}
| Record                | Type  | Data |
| --------------------- | ----- | ---- |
%{ for k, v in list ~}
|  ${k}            | CNAME |  ${v}  |
%{ endfor ~}
