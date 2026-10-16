output "instance_name" {
    description = "Name of the created compute engine instance"

    value = {
        for key, instance in google_compute_instance.vms :
        key => instance.name
    }
}

output "instance_private_ip" {
    description = "Private ip of the instance"

    value = {
        for key, instance in google_compute_instance.vms :
        key => instance.network_interface[0].network_ip
    }
}

output "instance_public_ip" {
    description = "Public ip of the instance"

    value = {
        for key, instance in google_compute_instance.vms:
        key => (
            length(instance.network_interface[0].access_config) > 0
            ? instance.network_interface[0].access_config[0].nat_ip : null
        )
    }
}