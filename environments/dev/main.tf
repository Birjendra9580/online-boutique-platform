locals {

  common_labels = {
    env        = "dev"
    app        = "online-boutique"
    managed_by = "terraform"
  }

  required_apis = toset([
    "artifactregistry.googleapis.com",
    "aiplatform.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com"
  ])

  # -----------------------------------------
  # NETWORK
  # -----------------------------------------

  networks = {
    dev_vpc = {
      name                    = "online-boutique-dev-vpc"
      description             = "vpc for online-boutique-dev application"
      auto_create_subnetworks = false
      routing_mode            = "REGIONAL"
    }
  }

  subnets = {
    dev_subnet = {
      name                     = "online-boutique-dev-subnet"
      network                  = "dev_vpc"
      region                   = var.region
      ip_cidr_range            = "10.10.0.0/20"
      private_ip_google_access = true

      secondary_ip_ranges = {
        gke-pods     = "10.20.0.0/16"
        gke-services = "10.30.0.0/20"
      }
    }
  }

  firewall_rules = {}

  # .............................
  # IAM
  # .............................

  service_accounts = {

    gke_nodes = {
      account_id   = "online-boutique-gke"
      display_name = "Online Boutique GKE node service account"
      description  = "Service account for Dev GKE nodes"
    }

    ci_cd = {
      account_id   = "online-boutique-cicd"
      display_name = "Online Boutique CI/CD service account"
      description  = "Service account for publishing container images"
    }
  }

  project_role_bindings = {

    gke_nodes_container = {
      service_account_key = "gke_nodes"
      role                = "roles/container.defaultNodeServiceAccount"
    }

    gke_nodes_logging = {
      service_account_key = "gke_nodes"
      role                = "roles/logging.logWriter"
    }

    gke_nodes_monitoring = {
      service_account_key = "gke_nodes"
      role                = "roles/monitoring.metricWriter"
    }

    gke_nodes_artifact_reader = {
      service_account_key = "gke_nodes"
      role                = "roles/artifactregistry.reader"
    }

    cicd_artifact_writer = {
      service_account_key = "ci_cd"
      role                = "roles/artifactregistry.writer"
    }
  }

  # ................................
  # ARTIFACT REGISTRY
  # ................................

  repositories = {

    adservice = {
      description    = "Online Boutique adservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    cartservice = {
      description    = "Online Boutique cartservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    checkoutservice = {
      description    = "Online Boutique checkoutservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    currencyservice = {
      description    = "Online Boutique currencyservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    emailservice = {
      description    = "Online Boutique emailservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    frontend = {
      description    = "Online Boutique frontend image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    loadgenerator = {
      description    = "Online Boutique loadgenerator image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    paymentservice = {
      description    = "Online Boutique paymentservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    productcatalogservice = {
      description    = "Online Boutique productcatalogservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    recommendationservice = {
      description    = "Online Boutique recommendationservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }

    shippingservice = {
      description    = "Online Boutique shippingservice image"
      location       = var.region
      immutable_tags = true
      labels         = local.common_labels
    }
  }

  # ---------------------------------------------------------
  # CLOUD STORAGE
  # ---------------------------------------------------------

  buckets = {
    application_data = {
      name                        = "online-boutique-dev-${var.bucket_suffix}"
      location                    = "ASIA-SOUTH1"
      storage_class               = "STANDARD"
      versioning_enabled          = true
      uniform_bucket_level_access = true
      public_access_prevention    = "enforced"
      force_destroy               = false
      labels                      = local.common_labels
    }
  }

  # ---------------------------------------------------------
  # BIGQUERY
  # ---------------------------------------------------------

  datasets = {
    online_boutique_dev = {
      location                   = var.region
      description                = "Online Boutique Dev analytics and event data"
      delete_contents_on_destroy = false
      max_time_travel_hours      = 168
      labels                     = local.common_labels
    }
  }

  # ---------------------------------------------------------
  # COMPUTE ENGINE
  # ---------------------------------------------------------

  instances = {}

  # ---------------------------------------------------------
  # GKE
  # ---------------------------------------------------------

  clusters = {
    dev = {
      name                = "online-boutique-dev-gke"
      location            = var.zone
      network_key         = "dev_vpc"
      subnet_key          = "dev_subnet"
      pods_range_name     = "gke-pods"
      services_range_name = "gke-services"

      release_channel         = "REGULAR"
      deletion_protection     = true
      enable_private_nodes    = true
      enable_private_endpoint = false
      master_ipv4_cidr_block  = "172.16.0.0/28"

      node_pools = {
        general = {
          name               = "online-boutique-dev-pool"
          machine_type       = "e2-standard-2"
          initial_node_count = 1
          disk_size_gb       = 50
          disk_type          = "pd-balanced"

          # This references the service account created by the IAM module.
          service_account_email = module.iam.service_account_emails["gke_nodes"]

          autoscaling_enabled = true
          min_node_count      = 1
          max_node_count      = 3

          auto_repair  = true
          auto_upgrade = true
          labels       = local.common_labels
        }
      }
    }
  }

  # ---------------------------------------------------------
  # VERTEX AI
  # ---------------------------------------------------------

  vertex_endpoints = {}

}

# ===========================================================
# ENABLE GOOGLE CLOUD APIS
# ===========================================================

resource "google_project_service" "required" {
  for_each = local.required_apis

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

# ===========================================================
# NETWORK MODULE
# ===========================================================

module "network" {
  source = "../../modules/network"

  project_id     = var.project_id
  region         = var.region
  networks       = local.networks
  subnets        = local.subnets
  firewall_rules = local.firewall_rules

  depends_on = [
    google_project_service.required
  ]
}

# ===========================================================
# IAM MODULE
# ===========================================================

module "iam" {
  source = "../../modules/iam"

  project_id            = var.project_id
  service_accounts      = local.service_accounts
  project_role_bindings = local.project_role_bindings

  depends_on = [google_project_service.required]
}

# ===========================================================
# ARTIFACT REGISTRY MODULE
# ===========================================================

module "artifact_registry" {
  source = "../../modules/artifact_registry"

  project_id   = var.project_id
  repositories = local.repositories
  depends_on   = [google_project_service.required]
}

# ===========================================================
# STORAGE MODULE
# ===========================================================

module "storage" {
  source = "../../modules/storage"

  project_id = var.project_id
  buckets    = local.buckets
  depends_on = [google_project_service.required]
}

# ===========================================================
# BIGQUERY MODULE
# ===========================================================

module "bigquery" {
  source = "../../modules/bigquery"

  project_id = var.project_id
  datasets   = local.datasets

  depends_on = [
    google_project_service.required
  ]
}

# ===========================================================
# COMPUTE MODULE
# ===========================================================

module "compute" {
  source = "../../modules/compute"

  project_id        = var.project_id
  instances         = local.instances
  subnet_self_links = module.network.subnet_self_links

  depends_on = [
    google_project_service.required,
    module.network
  ]
}

# ===========================================================
# GKE MODULE
# ===========================================================

module "gke" {
  source = "../../modules/gke"

  project_id        = var.project_id
  network_self_link = module.network.network_self_links
  subnet_self_link  = module.network.subnet_self_links
  clusters          = local.clusters

  depends_on = [
    google_project_service.required,
    module.network,
    module.iam
  ]
}

# ===========================================================
# VERTEX AI MODULE
# ===========================================================

module "vertex_ai" {
  source = "../../modules/vertex_ai"

  project_id = var.project_id
  endpoints  = local.vertex_endpoints

  depends_on = [
    google_project_service.required
  ]
}