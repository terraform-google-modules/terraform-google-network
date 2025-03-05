/*
  Description: Main module logic
*/

module "run_command_get_network_rules_subnet_status" {
  source = "../terraform-external-run-command"

  command = <<-EOT
    az storage account network-rule list
      --resource-group "${var.resource_group}"
      --account-name "${var.storage_account_name}"
      | jq -r '.virtualNetworkRules[].virtualNetworkResourceId | select(.=="${var.subnet_id}")'
  EOT
}

locals {
  missing_subnet_network_rule_status  = module.run_command_get_network_rules_subnet_status.result == var.subnet_id
  trigger_prefix                      = "Replacement Notice: storage account network rule for subnet not found, destroy and recreate to enforce presence of network rule"
  missing_subnet_network_rule_trigger = local.missing_subnet_network_rule_status ? local.trigger_prefix : split(";", "${local.trigger_prefix};${timestamp()}")[0]
}

resource "null_resource" "maintain_subnet_network_rule" {
  triggers = {
    resource_group       = var.resource_group
    storage_account_name = var.storage_account_name
    subnet_id            = var.subnet_id
    trigger              = local.missing_subnet_network_rule_trigger
  }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      if [ "${local.missing_subnet_network_rule_status}" == "true" ]; then \
        echo "Storage Account network rule for subnet already found."; \
      else \
        echo "Adding Storage Account network rule for subnet: ${self.triggers.subnet_id}"; \
        sleep 3; \
        do=true; \
        counter=0; \
        while $do || [[ "$ADD_SUBNET" != "${self.triggers.subnet_id}" ]] || [ $counter -lt 3 ]; do \
          do=false; \
          echo "Still adding Storage Account network rule..."; \
          ADD_SUBNET=$( \
            az storage account network-rule add \
              --account-name ${self.triggers.storage_account_name} \
              --resource-group ${self.triggers.resource_group} \
              --subnet ${self.triggers.subnet_id} \
              | jq -r '.networkRuleSet.virtualNetworkRules[].virtualNetworkResourceId | select(.=="${self.triggers.subnet_id}")' \
          ); \
          sleep 5; \
          [[ "$ADD_SUBNET" == "${self.triggers.subnet_id}" ]] && counter=$((counter+1)); \
        done && \
        echo "Successfully added Storage Account network rule for subnet: $ADD_SUBNET"; \
      fi
    EOT
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      echo "Removing Storage Account network rule for subnet: ${self.triggers.subnet_id}"; \
      sleep 3; \
      do=true; \
      counter=0; \
      while $do || [[ "$REMOVE_SUBNET" == "${self.triggers.subnet_id}" ]] || [ $counter -lt 3 ]; do \
        do=false; \
        echo "Still removing Storage Account network rule..."; \
        REMOVE_SUBNET=$( \
          az storage account network-rule remove \
            --account-name ${self.triggers.storage_account_name} \
            --resource-group ${self.triggers.resource_group} \
            --subnet ${self.triggers.subnet_id} \
            | jq -r '.networkRuleSet.virtualNetworkRules[].virtualNetworkResourceId | select(.=="${self.triggers.subnet_id}")' \
        ); \
        sleep 5; \
        [[ "$REMOVE_SUBNET" != "${self.triggers.subnet_id}" ]] && counter=$((counter+1)); \
      done && \
      echo "Successfully removed Storage Account network rule for subnet: ${self.triggers.subnet_id}"
    EOT
  }
}
