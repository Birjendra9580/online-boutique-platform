resource "google_compute_instance" "vms" {
    for_each = var.instances

    project      = var.project_id
    name         = each.value.name
    zone         = each.value.zone
    machine_type = each.value.machine_type
    tags         = each.value.tags
    labels       = each.value.labels

    boot_disk {
        initialize_params {
            image = each.value.image
            size  = each.value.boot_disk_size_gb 
            type  = each.value.boot_disk_type
        }
    }

    network_interface {
        subnetwork = var.subnet_self_links[each.value.subnet_key]

        dynamic "access_config" {
            for_each = each.value.assign_public_ip ? [1] : []
            content {}
        }
    }

    dynamic "service_account" {
        for_each = each.value.service_account_email == null ? [] : [each.value.service_account_email] 
        content {
            email  = service_account.value
            scopes = ["cloud-platform"]
        }
    }

    metadata = each.value.metadata

  
}