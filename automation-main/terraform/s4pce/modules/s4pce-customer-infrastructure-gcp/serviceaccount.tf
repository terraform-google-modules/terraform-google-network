/*
  Description: Create service account for customer
  Comments:
    - N/A
*/

#### Google Service Account
module "context_service_account" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = module.module_context.context

  name        = module.module_context.customer
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} service account"
}

resource "google_service_account" "service_account" {
  account_id   = "${module.context_service_account.customer}-compute"
  display_name = "${module.context_service_account.customer}-serviceaccount"
  description  = module.context_service_account.description
}


### Create custom role
resource "google_project_iam_custom_role" "serviceaccountrole" {
  role_id     = "${module.context_service_account.customer}_role"
  title       = "${module.context_service_account.customer}-role"
  description = module.context_service_account.description
  permissions = ["compute.disks.addResourcePolicies", "compute.disks.create", "compute.disks.createSnapshot", "compute.disks.get",
    "compute.disks.list", "compute.disks.setLabels", "compute.disks.use", "compute.firewalls.list",
    "compute.forwardingRules.list", "compute.globalOperations.get", "compute.instances.attachDisk", "compute.instances.get",
    "compute.instances.getGuestAttributes", "compute.instances.list", "compute.instances.useReadOnly", "compute.machineImages.create",
    "compute.machineImages.get", "compute.networks.list", "compute.regions.list", "compute.resourcePolicies.use", "compute.subnetworks.list",
    "compute.zoneOperations.get", "compute.zones.list", "iam.serviceAccounts.actAs", "logging.logEntries.create", "monitoring.timeSeries.create",
    "osconfig.inventories.get", "osconfig.inventories.list", "resourcemanager.projects.get", "storage.buckets.list", "workflows.executions.create",
  ]
}

### Assign custom role to service account
resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = google_service_account.service_account.name
  role               = google_project_iam_custom_role.serviceaccountrole.name
  member             = "serviceAccount:${google_service_account.service_account.email}"
}
