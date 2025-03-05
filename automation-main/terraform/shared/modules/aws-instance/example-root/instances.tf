/*
  Description: Handles exemplifying usage of aws-instance module; This shows how to integrate the aws-instance module into a root module
  Comments:
    - Each instance must be specified as seperate module calls in the root module
    - The first calling module demonstrates the minimum required fields
    - The second calling module shows all possible options along with their defaults if not specified.
    - Commented out blocks without cluttering line-by-line comments provided for convenience
*/

#####################
# Instance Examples #
#####################

##### The following Example lists all required input options to start an AWS Instance with this module
module "EXAMPLE_01_INSTANCE_WITH_ONLY_REQUIRED_OPTIONS" {
  source              = "../../../modules/aws-instance"
  search_ami_name     = "Golden-NS2-RHEL-7.6-Base-V*"  # The expression to look for the AMI that the instance will use
  search_ami_owner_id = "723712175675"                 # The account id of the AMI owner
  ec2_key             = aws_key_pair.key_pair.key_name # Name of the AWS keypair to use for the instance
  security_group_ids = [
    aws_default_security_group.test_vpc.id
  ]                                                              # List of Security group IDs to apply to the Instance
  subnet_id            = aws_subnet.test_vpc.id                  # Subnet ID where the instance should live
  iam_instance_profile = aws_iam_role.iam_role.name              # IAM Profile to attach to the instance
  aws_region           = var.aws_region                          # AWS Region
  build_user           = var.build_user                          # User id of individual executing terraform; must be defined for auditing purposes
  tag_business         = "ns2"                                   # Line of business which the resource is related to e.g., `ns2`, `ibp`, `scp`, `sac`, `hcm`
  tag_customer         = "test"                                  # Customer that uses the deployed system e.g., `management`, `customer00006`
  tag_description      = "Minimum instance module usage example" # Friendly description of the purpose of the system
  tag_environment      = "production_development_"               # Related management plane e.g., `staging`, `production`, `management`
  tag_name             = "testing"                               # AWS Tag Name of the instance. Conventionally a single word category the instance belongs to. A Random hex string will be added to ensure uniqueness
  tag_owner            = "EXAMPLE_DL@sapns2.com"                 # Email address directing communication for that party responsible for the system e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com`
  tag_platform         = "unlicensed"                            # Used by the Asset Management team e.g., `licensed` (Windows) or `unlicensed` (Red Hat Linux)
  tag_productname      = "product"                               # Application/product name being deployed e.g., `hana`, `nessus`, `concourse`
  module_dependency    = join(",", [])                           # Used by root modules to create a dependency for order of operation purposes
}

// module "EXAMPLE_INSTANCE_WITH_ONLY_REQUIRED_OPTIONS" {
//   source = "../../../modules/aws-instance"
//   search_ami_name        = "Golden-NS2-RHEL-7.6-Base-V*"
//   search_ami_owner_id    = "723712175675"
//   ec2_key                = aws_key_pair.key_pair.key_name
//   security_group_ids     = [
//     aws_default_security_group.test_vpc.id
//   ]
//   subnet_id              = aws_subnet.test_vpc.id
//   iam_instance_profile   = aws_iam_role.iam_role.name
//   aws_region             = var.aws_region
//   build_user             = var.build_user
//   tag_business           = "ns2"
//   tag_customer           = "management"
//   tag_description        = "Minimum instance module usage example"
//   tag_environment        = "production_development_"
//   tag_name               = "testing"
//   tag_owner              = "EXAMPLE_DL@sapns2.com"
//   tag_platform           = "unlicensed"
//   tag_productname        = "product"
//   module_dependency = join(",",[])
// }


##### The following Example lists all available options. All listed options are defaults if unspecified
module "EXAMPLE_02_INSTANCE_WITH_FULL_OPTIONS" {
  source = "../../../modules/aws-instance"
  ### Mandatory values. These must be specified when calling module
  search_ami_name     = "Golden-NS2-RHEL-8.2-Base-V*"  # The expression to look for the AMI that the instance will use
  search_ami_owner_id = "723712175675"                 # The account id of the AMI owner
  ec2_key             = aws_key_pair.key_pair.key_name # Name of the AWS keypair to use for the instance
  security_group_ids = [
    aws_default_security_group.test_vpc.id
  ]                                                          # List of Security group IDs to apply to the Instance
  subnet_id            = aws_subnet.test_vpc.id              # Subnet ID where the instance should live
  iam_instance_profile = aws_iam_role.iam_role.name          # IAM Profile to attach to the instance
  aws_region           = var.aws_region                      # AWS Region
  build_user           = var.build_user                      # User id of individual executing terraform; must be defined for auditing purposes
  tag_business         = "ns2"                               # Line of business which the resource is related to e.g., `ns2`, `ibp`, `scp`, `sac`, `hcm`
  tag_customer         = "test"                              # Customer that uses the deployed system e.g., `management`, `customer00006`
  tag_description      = "Full Options module usage example" # Friendly description of the purpose of the system
  tag_environment      = "production_development_"           # Related management plane e.g., `staging`, `production`, `management`
  tag_name             = "testing"                           # AWS Tag Name of the instance. Conventionally a single word category the instance belongs to. A Random hex string will be added to ensure uniqueness
  tag_owner            = "EXAMPLE_DL@sapns2.com"             # Email address directing communication for that party responsible for the system e.g., `isso@sapns2.com`, `isse@sapsn2.com`, `dhibpops@sapns2.com`
  tag_platform         = "unlicensed"                        # Used by the Asset Management team e.g., `licensed` (Windows) or `unlicensed` (Red Hat Linux)
  tag_productname      = "product"                           # Application/product name being deployed e.g., `hana`, `nessus`, `concourse`
  module_dependency    = join(",", [])                       # Used by root modules to create a dependency for order of operation purposes
  ### Optional values. (may be removed if not modifying)
  # Values specified below have defaults or will be ignored if not passed by calling module
  instance_type           = "m5.large"                        # AWS Instance type. m5.large required to test placement groups. Default: t3.micro
  host_id                 = null                              # (Optional) Specifies dedicated host to be deployed to.
  disable_api_termination = false                             # (boolean) Prevent destroy in AWS Console
  enable_state_recovery   = false                             # (boolean) Enables cloudwatch hardware state recovery
  monitoring              = false                             # (boolean) Enables detailed cloudwatch monitoring
  placement_group         = aws_placement_group.test_vpc.name # Which placement group to put the instance in. Default: ""
  # Root Volume Variables
  root_type                  = "standard" # Type of Root volume: standard, gp2, io1, sc1, st1
  root_size                  = "100"      # Size of the Root volume in GiB
  root_delete_on_termination = false      # (boolean) Deletes root volume on instance termination
  root_encrypted             = false      # (boolean) Encrypts the root volume
  # Networking Variables
  associate_public_ip_address  = false           # (boolean) Create Instance with a dynamically assigned public IP Address
  associate_elastic_ip_address = false           # (boolean) Create Instance with an Elastic IP address
  source_dest_check            = true            # (boolean) If true, AWS enforces layer3 source/destination checks on traffic passing through the network interface
  static_private_ip            = "192.168.1.100" # (string) Optional static IP created for the Instance. This is not recommended.
  # Route53 Variables
  route53_associate_private_ip_address = false # (boolean) Create DNS A record for instance ID in passed route53 zone
  route53_zoneid                       = ""    # Zone ID for the Route53 zone for creating DNS records. Must be set if route53_associate_private_ip_address = true
  route53_ttl                          = "300" # Value for Route53 TTL in seconds
  route53_associate_cname              = false # (boolean) Only if route53_associate_private_ip_address is set to true, create standard CNAME for created DNS A record using passed instance tags, instance private ip CIDR, and availability zone
  route53_additional_cnames            = []    # (list) Only if route53_associate_cname is satisfied and set to true, additional list of custom CNAMEs to provision for created DNS A record
  # Tagging Variables
  tag_managedby        = "terraform" # Indicates what technology is used to continuously configure the resource e.g., `terraform`, `ansible`
  tag_patchgroup       = ""          # Group of systems that should be patched together during maintenance windows. A blank will be ignored.
  tag_productcluster   = ""          # A more granular name of the specific cluster/deployment of a product when deploying the same product multiple times in a single hosted zone and clarification is needed. e.g., `pki` a second Hashicorp Vault deployed specifically for PKI
  tag_productcomponent = ""          # The name of the subcomponent of the product only when product is broken into multiple subcomponents. e.g., `web`, `worker` (Concourse), `indexer` (Splunk)
  tag_productvendor    = ""          # The name of the vendor/brand of the product. e.g., `tenable`, `sap`, `hashicorp`
  tag_productversion   = ""          # Specific version or variant of product e.g., `8.1.2`, `R40`, `v3.0`. A blank will be ignored.
  tag_scangroup        = ""          # Group of systems that should be scanned together during scheduled scan windows. A blank will be ignored.
  # Bootstrap Variables (can be removed entirely if not used)
  bootstrap_enable       = false    # Flag to turn instance bootstrap process via userdata on/off, `true` - enables boostrap, `false` - disables bootstrap
  custom_bootstrap       = ""       # When defined and `bootstrap_enable` is set to `true`, allows for a custom base64 encoded bootstrap string to be applied to the instance via userdata
  git_repository         = ""       # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git repository to download, leave out 'http(s)' url prefix. A blank will be ignored.
  git_branch             = "master" # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, specific branch of git repository to download
  git_repository_path    = ""       # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, path on system where to clone git repository to if specified
  git_repository_cleanup = true     # (boolean) When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, flag to tell boostrap process to removed cloned repository from system when finished
  git_name               = ""       # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git username to download repositories. A blank will be ignored.
  git_token              = ""       # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, git token to download repositories. A blank will be ignored.
  bootstrap_commands     = []       # When `bootstrap_enable` is set to `true` and `custom_bootstrap` left blank, single line bash command to execute within root of downloaded git repository. A blank will be ignored.
}

### NOTICE: Please copy and uncomment the below as a starting point for usage of the aws-instance module

// module "EXAMPLE_INSTANCE_WITH_FULL_OPTIONS" {
//   source = "../../../modules/aws-instance"
//   ### Mandatory values. These must be specified when calling module
//   search_ami_name        = "Golden-NS2-RHEL-7.6-Base-V*"
//   search_ami_owner_id    = "723712175675"
//   ec2_key                = aws_key_pair.key_pair.key_name
//   security_group_ids     = [
//     aws_default_security_group.test_vpc.id
//   ]
//   subnet_id              = aws_subnet.test_vpc.id
//   iam_instance_profile   = aws_iam_role.iam_role.name
//   aws_region             = var.aws_region
//   build_user             = var.build_user
//   tag_business           = "ns2"
//   tag_customer           = "management"
//   tag_description        = "Minimum instance module usage example"
//   tag_environment        = "production_development_"
//   tag_name               = "testing"
//   tag_owner              = "EXAMPLE_DL@sapns2.com"
//   tag_platform           = "unlicensed"
//   tag_productname        = "product"
//   module_dependency = join(",",[])
//   ### Optional values. (may be removed if not modifying)
//   # Values specified below have defaults or will be ignored if not specified
//   instance_type                         = "t3.micro"
//   host_id                               = null
//   disable_api_termination               = false
//   enable_state_recovery                 = false
//   monitoring                            = false
//   placement_group                       = ""
//   # Root Volume Variables
//   root_type                             = "standard"
//   root_size                             = "100"
//   root_delete_on_termination            = false
//   root_encrypted                        = false
//   # Networking Variables
//   associate_public_ip_address           = false
//   associate_elastic_ip_address          = false
//   source_dest_check                     = true
//   static_private_ip                     = null
//   # Route53 Variables
//   route53_associate_private_ip_address  = false
//   route53_zoneid                        = ""
//   route53_ttl                           = "300"
//   route53_associate_cname               = false
//   route53_additional_cnames             = []
//   # Tagging Variables
//   tag_managedby                         = "terraform"
//   tag_patchgroup                        = ""
//   tag_productcluster                    = ""
//   tag_productcomponent                  = ""
//   tag_productvendor                     = ""
//   tag_patchgroup                        = ""
//   tag_productversion                    = ""
//   tag_scangroup                         = ""
//   # Bootstrap Variables (can be removed entirely if not used)
//   bootstrap_enable                      = false
//   custom_bootstrap                      = ""
//   git_repository                        = ""
//   git_branch                            = "master"
//   git_repository_path                   = ""
//   git_repository_cleanup                = true
//   git_name                              = ""
//   git_token                             = ""
//   bootstrap_command                     = ""
// }
