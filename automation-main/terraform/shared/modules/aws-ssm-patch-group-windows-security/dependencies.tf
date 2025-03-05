/*
  Description: Handle module dependencies and unique ID naming conventions; NA
  Comments: NA
*/

##### Force a module dependency if wanted
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

##### Generate a Random Name for the patch group
resource "random_id" "patch_group" {
  prefix = "${var.patch_group_name}-baseline-"
  # Generate a new ID if any of these values change.
  keepers = {
    patch_group_name = var.patch_group_name
  }
  byte_length = 8
}
