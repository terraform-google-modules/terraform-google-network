# get_vmss_privateip.tpl
# In terraform, we cannot get the private IPs of the instances. Hence az cli is used.
#!/bin/bash

total=`az vmss show \
    --resource-group cre-s4-pce-EXAMPLE0001 \
    --subscription 31054f6c-70ac-4d89-a613-e008ecc04476 \
    --name cre-s4-pce-EXAMPLE0001-sftp-ps4-scaleset \
    --query 'sku.capacity'`
total_new=$((total-1))
result=""
for i in `seq 0 $total_new`
do
output=$(az resource show \
    --resource-group cre-s4-pce-EXAMPLE0001 \
    --resource-type Microsoft.Compute/virtualMachineScaleSets \
    --api-version 2017-03-30 \
    --name cre-s4-pce-EXAMPLE0001-sftp-ps4-scaleset/virtualMachines/$i/networkInterfaces \
    --query 'value[0].properties.ipConfigurations[0].properties' \
| jq -c '{privateIPAddress}')
p=$(echo "$output" | sed "s/:/_/" | sed "s/{//"| sed "s/}//" | sed "s/\"_\"/_/" | sed "s/privateIPAddress_//" | sed "s/\"//"  | sed "s/\"//")
result="$result$p"
if [[ $i -ne $total_new ]]; then
    result="$result,"
fi
done
echo "{\"private_ips\":\"$result\"}"
