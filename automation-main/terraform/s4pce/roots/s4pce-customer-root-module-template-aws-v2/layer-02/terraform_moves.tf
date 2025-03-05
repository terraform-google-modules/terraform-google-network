# Instances
moved {
  from = module.instance_list
  to   = module.s4pce_customer_instances.module.instance_list
}
moved {
  from = module.context_instance_list
  to   = module.s4pce_customer_instances.module.context_instance_list
}
moved {
  from = module.context_instance_rhel
  to   = module.s4pce_customer_instances.module.context_instance_rhel
}
moved {
  from = module.context_instance_ubuntu
  to   = module.s4pce_customer_instances.module.context_instance_ubuntu
}
moved {
  from = module.context_instance_windows
  to   = module.s4pce_customer_instances.module.context_instance_windows
}
moved {
  from = module.instance_saprouter
  to   = module.s4pce_customer_instances.module.instance_saprouter
}

# Keypairs
moved {
  from = aws_key_pair.main01
  to   = module.s4pce_customer_instances.aws_key_pair.main01
}

# Security Groups
moved {
  from = aws_security_group.saprouter[0]
  to   = module.s4pce_customer_instances.aws_security_group.saprouter[0]
}
moved {
  from = module.context_aws_security_group_saprouter[0].time_static.time
  to   = module.s4pce_customer_instances.module.context_aws_security_group_saprouter[0].time_static.time
}
moved {
  from = aws_security_group_rule.saprouter_standard_ingress[0]
  to   = module.s4pce_customer_instances.aws_security_group_rule.saprouter_standard_ingress[0]
}
