resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 0.4.0"

  # Give the network a name and project
  project_id   = "${google_project_service.compute.project}"
  network_name = "my-custom-vpc"

  subnets = [
    {
      # Creates your first subnet in us-west1 and defines a range for it
      subnet_name   = "my-first-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      # Creates a dedicated subnet for GKE
      subnet_name   = "my-gke-subnet"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "us-west1"
    },
  ]

  # Define secondary ranges for each of your subnets
  secondary_ranges = {
    my-first-subnet = []

    my-gke-subnet = [
      {
        # Define a secondary range for Kubernetes pods to use
        range_name    = "my-gke-pods-range"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]
  }
}
