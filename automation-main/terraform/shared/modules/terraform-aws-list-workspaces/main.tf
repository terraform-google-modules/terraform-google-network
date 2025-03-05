/*
  Description: Main module logic
*/

locals {
  # ensure folder path has trailing '/'
  folder_path      = var.folder_path == null ? null : substr(var.folder_path, -1, -1) != "/" ? "${var.folder_path}/" : var.folder_path
  folder_path_flag = local.folder_path == null ? null : "--prefix ${local.folder_path}"
  folder_path_awk  = local.folder_path == null ? null : "| awk -F '${local.folder_path}' '{ print $2 }'"
}

module "run_command_get_workspaces" {
  source = "../terraform-external-run-command"

  command = <<-EOT
    aws s3api list-objects-v2
      --bucket ${var.s3_bucket_name}
      ${local.folder_path_flag}
      | jq -r '.Contents | map(select(.Size > 200) | .Key) | join("\n")'
      ${local.folder_path_awk}
      | awk -F '/' '{ print $1 }'
      | tr '\n' ';'
  EOT
}

locals {
  queried_worksapces = compact(split(";", module.run_command_get_workspaces.result))
}

output "workspaces" { value = local.queried_worksapces }
