/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments:
*/

### AWS Variables
aws_region = "EXAMPLE_REGION"

interface_bucket_write_arns = [
  #"arn:aws-us-gov:iam::99999999:role/example-role-arn"
  #"arn:aws-us-gov:iam::99999999:root" # Example account arn
]

customer_account_id = "99999999"
customer_bucket_names = [
  #   "example-name",
]

### Uncomment and populate these values before running terraform
// build_user = ""


access_points = {
  example1 = {
    posix_user     = null
    root_directory = null
  }
  example2 = {
    posix_user = {
      uid = 0
      gid = 0
    }
    root_directory = {
      path          = "/my/custom/path"
      creation_info = null
  } }
  example3 = {
    posix_user = null
    root_directory = {
      path = "/my/custom/path"
      creation_info = {
        owner_gid   = 0
        owner_uid   = 0
        permissions = 777
  } } }
}
