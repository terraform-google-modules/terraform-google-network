# Upgrading to v2.x

The v2.x release of _google-network_ is a backwards incompatible
release.

Because v2.x changed how the subnet resource is iterated on, resources in Terraform state need to be migrated in order to avoid the resources from getting destroyed and recreated.

## Migration Instructions

-   Upgrade to the new version of this module.

if you run `terraform plan` at this point. Terraform will inform you that it will attempt to delete and recreate your existing subnets. This is almost certainly not the behavior you want. For example:

```Shell
Terraform will perform the following actions:

  # module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork will be destroyed
  - resource "google_compute_subnetwork" "subnetwork" {
      - creation_timestamp       = "2019-10-02T08:40:26.282-07:00" -> null
      - enable_flow_logs         = false -> null
      - fingerprint              = "f8LZx006zY4=" -> null
      - gateway_address          = "10.10.10.1" -> null
      - id                       = "us-west1/simple-project-timh-subnet-01" -> null
      - ip_cidr_range            = "10.10.10.0/24" -> null
      - name                     = "simple-project-timh-subnet-01" -> null
      - network                  = "https://www.googleapis.com/compute/v1/projects/dev-xpn-networking/global/networks/simple-project-timh" -> null
      - private_ip_google_access = false -> null
      - project                  = "dev-xpn-networking" -> null
      - region                   = "us-west1" -> null
      - secondary_ip_range       = [] -> null
      - self_link                = "https://www.googleapis.com/compute/v1/projects/dev-xpn-networking/regions/us-west1/subnetworks/simple-project-timh-subnet-01" -> null
    }

  # module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[1] will be destroyed
  - resource "google_compute_subnetwork" "subnetwork" {
      - creation_timestamp       = "2019-10-02T08:40:26.292-07:00" -> null
      - enable_flow_logs         = true -> null
      - fingerprint              = "wOwStN9lK-Q=" -> null
      - gateway_address          = "10.10.20.1" -> null
      - id                       = "us-west1/simple-project-timh-subnet-02" -> null
      - ip_cidr_range            = "10.10.20.0/24" -> null
      - name                     = "simple-project-timh-subnet-02" -> null
      - network                  = "https://www.googleapis.com/compute/v1/projects/dev-xpn-networking/global/networks/simple-project-timh" -> null
      - private_ip_google_access = true -> null
      - project                  = "dev-xpn-networking" -> null
      - region                   = "us-west1" -> null
      - secondary_ip_range       = [] -> null
      - self_link                = "https://www.googleapis.com/compute/v1/projects/dev-xpn-networking/regions/us-west1/subnetworks/simple-project-timh-subnet-02" -> null
    }

  # module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork["us-west1/simple-project-timh-subnet-01"] will be created
  + resource "google_compute_subnetwork" "subnetwork" {
      + creation_timestamp       = (known after apply)
      + enable_flow_logs         = false
      + fingerprint              = (known after apply)
      + gateway_address          = (known after apply)
      + id                       = (known after apply)
      + ip_cidr_range            = "10.10.10.0/24"
      + name                     = "simple-project-timh-subnet-01"
      + network                  = "simple-project-timh"
      + private_ip_google_access = false
      + project                  = "dev-xpn-networking"
      + region                   = "us-west1"
      + secondary_ip_range       = []
      + self_link                = (known after apply)
    }

  # module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork["us-west1/simple-project-timh-subnet-02"] will be created
  + resource "google_compute_subnetwork" "subnetwork" {
      + creation_timestamp       = (known after apply)
      + enable_flow_logs         = true
      + fingerprint              = (known after apply)
      + gateway_address          = (known after apply)
      + id                       = (known after apply)
      + ip_cidr_range            = "10.10.20.0/24"
      + name                     = "simple-project-timh-subnet-02"
      + network                  = "simple-project-timh"
      + private_ip_google_access = true
      + project                  = "dev-xpn-networking"
      + region                   = "us-west1"
      + secondary_ip_range       = []
      + self_link                = (known after apply)
    }

Plan: 2 to add, 0 to change, 2 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

### Manual Migration Steps

In this example here are the two commands used migrate the subnets created by the `simple_project` in the examples directory.  _please note the need to escape the quotes on the new resource_. You may also use the migration script.

-   `terraform state mv module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[0] module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-01\"]`

-   `terraform state mv module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[1] module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-02\"]`

`terraform plan` should now return a no-op and show no new changes.

```Shell
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.example.module.test-vpc-module.google_compute_network.network: Refreshing state... [id=simple-project-timh]
module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork["us-west1/simple-project-timh-subnet-02"]: Refreshing state... [id=us-west1/simple-project-timh-subnet-02]
module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork["us-west1/simple-project-timh-subnet-01"]: Refreshing state... [id=us-west1/simple-project-timh-subnet-01]

------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

### Migration Script

1.  Download the script

    ```sh
    curl -O https://raw.githubusercontent.com/terraform-google-modules/terraform-google-network/master/scripts/migrate.sh
    chmod +x migrate.sh
    ```

2.  Run the script to output the migration commands:

    ```sh
    $ MODULE_NAME="test-vpc-module" ./migrate.sh --dry-run
    terraform state mv module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[0] module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-01\"]
    terraform state mv module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[1] module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-02\"]
    ```

3.  Execute the migration command

    ```sh
    $ MODULE_NAME="test-vpc-module" ./migrate.sh
    Move "module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[0]" to "module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-01\"]"
    Successfully moved 1 object(s).
    Move "module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[1]" to "module.example.module.test-vpc-module.google_compute_subnetwork.subnetwork[\"us-west1/simple-project-timh-subnet-02\"]"
    Successfully moved 1 object(s).
    ```

4.  Run `terraform plan` to confirm no changes are expected.
