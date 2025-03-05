/*
  Description: Filestore modules for creating NFS storage
  Comments:
    - N/A
*/

module "context_filestore_customer_usr_sap_trans" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = module.module_context.customer # 16 char limit
  description = "Filestore for /usr/sap/trans"
  flags       = { override_name = true }
}

locals {
  cloudfuctions_v2_only_region_list = ["asia-south2", "australia-southeast2", "europe-north1", "europe-west4", "northamerica-northeast2", "southamerica-west1"]
  deploy_cloudfunction_v1           = contains(local.cloudfuctions_v2_only_region_list, module.module_context.region) ? 0 : 1
}

resource "google_filestore_instance" "customer_usr_sap_trans" {
  name        = module.context_filestore_customer_usr_sap_trans.name
  description = module.context_filestore_customer_usr_sap_trans.description
  zone        = "${module.module_context.region}-a"
  tier        = "STANDARD"

  labels = module.context_filestore_customer_usr_sap_trans.labels

  file_shares {
    capacity_gb = var.filestore_size
    name        = module.context_filestore_customer_usr_sap_trans.name
  }

  networks {
    network = google_compute_network.customer.name
    modes   = ["MODE_IPV4"]
  }
}

module "context_filestore_customer_usr_sap_trans_backup" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = "backup"
  description = "Customer filestore backup"
}

resource "google_cloudfunctions_function" "fs_backup" {
  count       = local.deploy_cloudfunction_v1
  name        = module.context_filestore_customer_usr_sap_trans_backup.name
  description = module.context_filestore_customer_usr_sap_trans_backup.description
  runtime     = "python37"

  source_archive_bucket = var.cloud_functions_bucket
  source_archive_object = var.cloud_function_fsbackup_source
  environment_variables = {
    REGION   = module.module_context.region
    CUSTOMER = module.module_context.customer
  }
  max_instances         = 3000
  trigger_http          = true
  entry_point           = "create_backup"
  service_account_email = "backupagent@${trimprefix(data.google_project.current.id, "projects/")}.iam.gserviceaccount.com"

}

# IAM entry for a single user to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  count          = local.deploy_cloudfunction_v1
  project        = google_cloudfunctions_function.fs_backup[count.index].project
  region         = google_cloudfunctions_function.fs_backup[count.index].region
  cloud_function = google_cloudfunctions_function.fs_backup[count.index].name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:schedulerunner@${trimprefix(data.google_project.current.id, "projects/")}.iam.gserviceaccount.com"
}

resource "google_cloud_scheduler_job" "fs_backup" {
  count            = local.deploy_cloudfunction_v1
  name             = module.context_filestore_customer_usr_sap_trans_backup.name
  description      = module.context_filestore_customer_usr_sap_trans_backup.description
  schedule         = "0 5 * * *"
  time_zone        = "Etc/UTC"
  attempt_deadline = "180s"

  http_target {
    http_method = "GET"
    uri         = "https://${module.module_context.region}-${trimprefix(data.google_project.current.id, "projects/")}.cloudfunctions.net/${module.context_filestore_customer_usr_sap_trans_backup.name}"
    oidc_token {
      service_account_email = "schedulerunner@${trimprefix(data.google_project.current.id, "projects/")}.iam.gserviceaccount.com"
    }
  }
}
