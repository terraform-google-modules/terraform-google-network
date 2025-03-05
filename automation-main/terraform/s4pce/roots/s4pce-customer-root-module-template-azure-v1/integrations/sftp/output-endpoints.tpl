##
| Name                | Type | Data |
| ------------------- | ---- | ---- |
%{ for key, value in endpoint_list ~}
|  ${key} | A | ${value}  |
%{ endfor ~}
