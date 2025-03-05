/*
  Description: Creates Elastic IP and associates it to the AWS Instance
  Input Triggers:
    - associate_elastic_ip_address : String value, a value of "true" will trigger this file.
  Description: When triggered, this file will create and associate an EIP to the instance.
  Comments:
*/

##### Create EIP if needed
module "context_eip_instance" {
  source  = "../terraform-null-context/modules/legacy"
  count   = local.context_passed ? 1 : 0
  context = module.module_context[0].context

  flags = {
    override_name = true
    skip_checks   = true
  }

  name        = random_id.instance.hex
  description = "${random_id.instance.hex} Elastic IP"
}

resource "aws_eip" "instance" {
  count = var.associate_elastic_ip_address == true ? 1 : 0
  vpc   = true
  tags = local.context_passed ? module.context_eip_instance[0].tags : {
    BuildUser     = var.build_user
    Business      = var.tag_business
    Description   = "${random_id.instance.hex} Elastic IP"
    Environment   = var.tag_environment
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    Name          = random_id.instance.hex
    Owner         = var.tag_owner
    ProvisionDate = timestamp()
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

##### Associate newly created EIP to instance
resource "aws_eip_association" "instance" {
  count         = var.associate_elastic_ip_address == true ? 1 : 0
  instance_id   = aws_instance.instance.id
  allocation_id = aws_eip.instance[0].id
}
