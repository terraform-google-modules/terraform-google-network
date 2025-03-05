/*
  Description: Creates AWS Instance; Using options from the user this will create AWS Instance
  Comments:
    - A random hex value is automatically appended to the name via the random_id resource
    - The name does not automatically prepend the VPC information, this must be specified by the calling module
*/

### Find the latest AMI to build the instance
data "aws_ami" "instance" {
  most_recent = true
  filter {
    name   = var.search_ami_filter_type
    values = [var.search_ami_name]
  }
  owners = [var.search_ami_owner_id]
}

### Optional Bootstrap Variables
locals {
  bootstrap = var.bootstrap_enable ? (var.custom_bootstrap == "" ? base64encode(local.bootstrap_template) : var.custom_bootstrap) : null
  # Used only when bootstrap is enabled and 'custom_bootstrap' left empty:
  bootstrap_template_option = data.aws_ami.instance.platform == "windows" ? "bootstrap-windows.ps1" : "bootstrap-linux.sh"
  git_repository_path       = var.git_repository_path != "" ? var.git_repository_path : (data.aws_ami.instance.platform == "windows" ? "C:\\Windows\\Temp\\temprepo" : "/tmp/temprepo")
  bootstrap_command = join("; ", flatten([
    for command in var.bootstrap_commands : [command]
  ]))
  bootstrap_template = templatefile("${path.module}/files/${local.bootstrap_template_option}", {
    # NOTE: not every input is needed for every bootstrap option, however, it does not hurt to pass extra as they simply will not be used
    git_repository         = var.git_repository,
    git_branch             = var.git_branch,
    git_repository_path    = local.git_repository_path,
    git_repository_cleanup = var.git_repository_cleanup,
    git_name               = var.git_name,
    git_token              = var.git_token,
    bootstrap_command      = local.bootstrap_command
  })
}

### Create Instance based on found AMI
locals {
  additional_cnames_join = length(var.route53_additional_cnames) > 0 ? join(" ", var.route53_additional_cnames) : null
  additional_tags = merge(
    var.route53_associate_private_ip_address == true ? {
      DNSZone = data.aws_route53_zone.instance[0].name
    } : {},
    var.route53_associate_private_ip_address == true && local.additional_cnames_join != null ? {
      Cnames = local.additional_cnames_join
    } : {}
  )
  tags = merge(
    {
      # Derived Tags
      Account       = data.aws_caller_identity.current.account_id
      Image         = data.aws_ami.instance.name
      ProvisionDate = timestamp()
      GeneratedBy   = "terraform"
      # Optional Legacy Tags
      Description = var.tag_description
      ProductName = var.tag_productname
    },
    # Either-Or Tags (context or legacy)
    local.context_passed ? module.context_instance[0].tags : {
      BuildUser   = var.build_user
      Business    = var.tag_business
      Customer    = var.tag_customer
      Environment = var.tag_environment
      ManagedBy   = var.tag_managedby
      Owner       = var.tag_owner
      // tag must be  "PatchGroup", see tag note below for details
      Platform         = var.tag_platform
      ProductCluster   = var.tag_productcluster
      ProductComponent = var.tag_productcomponent
      ProductVendor    = var.tag_productvendor
      ProductVersion   = var.tag_productversion
      ScanGroup        = var.tag_scangroup
      SecurityBoundary = var.tag_securityboundary
    },
    # Override the `Name` tag to ensure presence of `/<RANDOM>` suffix
    #   Note: merge() function will always prioritize the later Name key
    {
      Name = random_id.instance.hex
    },
    var.release_lock != null ? { "ReleaseLock" = var.release_lock } : {},
    var.tag_patchgroup != null ? { PatchGroup = var.tag_patchgroup } : {},
    local.additional_tags
  )
}

module "context_instance" {
  source  = "../terraform-null-context/modules/legacy"
  count   = local.context_passed ? 1 : 0
  context = module.module_context[0].context

  flags = { override_name = true }
  name  = random_id.instance.hex

  additional_tags = local.additional_tags
}

resource "aws_instance" "instance" {
  tags                        = local.tags
  ami                         = data.aws_ami.instance.image_id
  instance_type               = var.instance_type
  host_id                     = var.host_id
  key_name                    = random_id.instance.keepers.key_name
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = random_id.instance.keepers.subnet_id
  private_ip                  = var.static_private_ip
  associate_public_ip_address = random_id.instance.keepers.associate_public_ip_address
  disable_api_termination     = var.disable_api_termination
  iam_instance_profile        = var.iam_instance_profile
  monitoring                  = var.monitoring
  placement_group             = var.placement_group
  source_dest_check           = var.source_dest_check
  ipv6_address_count          = var.ipv6_address_count
  tenancy                     = var.tenancy

  root_block_device {
    volume_type           = var.root_type
    volume_size           = var.root_size
    iops                  = contains(["gp3", "io1", "io2"], var.root_type) ? var.root_iops : null
    throughput            = var.root_type == "gp3" ? var.root_throughput : null
    encrypted             = var.root_encrypted
    delete_on_termination = var.root_delete_on_termination
  }

  metadata_options {
    http_endpoint = var.http_endpoint
    http_tokens   = var.http_tokens
  }

  user_data_base64                     = local.bootstrap
  instance_initiated_shutdown_behavior = "stop"

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      ami,
      ebs_optimized,
      user_data,
      user_data_base64,
      tags,
      root_block_device[0].tags,
      volume_tags,
    ]
  }

  depends_on = [
    random_id.instance
  ]
}

locals {
  enforce_tags = distinct(concat(
    var.enforce_tags,
    var.route53_associate_private_ip_address ? ["DNSZone"] : [],
    local.additional_cnames_join != null ? ["Cnames"] : [],
    var.tag_patchgroup != null ? ["PatchGroup"] : [],
    var.release_lock != null ? ["ReleaseLock"] : []
  ))
}
resource "aws_ec2_tag" "enforce" {
  for_each = toset(local.enforce_tags)

  resource_id = aws_instance.instance.id
  key         = each.key
  value       = local.tags[each.key]
}
