# get_vmss_privateip.tpl
# In terraform, we cannot get the private IPs of the instances. Hence az cli is used.
#!/bin/bash

total=`az vmss show \
    --resource-group ${resource_group} \
    --subscription ${subscription} \
    --name ${name} \
    --query 'sku.capacity'`
total_new=$((total-1))
result=""
for i in `seq 0 $total_new`
do
output=$(az resource show \
    --resource-group ${resource_group} \
    --resource-type Microsoft.Compute/virtualMachineScaleSets \
    --api-version 2017-03-30 \
    --name ${name}/virtualMachines/$i/networkInterfaces \
    --query 'value[0].properties.ipConfigurations[0].properties' \
| jq -c '{privateIPAddress}')
p=$(echo "$output" | sed "s/:/_/" | sed "s/{//"| sed "s/}//" | sed "s/\"_\"/_/" | sed "s/privateIPAddress_//" | sed "s/\"//"  | sed "s/\"//")
result="$result$p"
if [[ $i -ne $total_new ]]; then
    result="$result,"
fi
done
echo "{\"private_ips\":\"$result\"}"
