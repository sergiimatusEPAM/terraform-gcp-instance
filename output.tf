# Number of Instance
output "num_instances" {
  value = "${var.num_instances}"
}

# Cluster Name
output "name_prefix" {
  value = "${var.name_prefix}"
}

# Instance Type
output "machine_type" {
  value = "${var.machine_type}"
}

# DCOS Version for prereq install
output "dcos_version" {
  value = "${var.dcos_version}"
}

# Tested OSes to install with prereq
output "dcos_instance_os" {
  value = "${var.dcos_instance_os}"
}

# Element by zone list
output "zone_list" {
  value = "${var.zone_list}"
}

# Source image to boot from
output "image" {
  value = "${var.image}"
}

# Disk Type to Leverage
output "disk_type" {
  value = "${var.disk_type}"
}

# Disk Size in GB
output "disk_size" {
  value = "${var.disk_size}"
}

# Instance Subnetwork Name
output "instance_subnetwork_name" {
  value = "${var.instance_subnetwork_name}"
}

# Customer Provided Userdata
output "user_data" {
  value = "${var.user_data}"
}

# SSH User
output "ssh_user" {
  value = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}"
}

# SSH Public Key
output "public_ssh_key" {
  value = "${var.public_ssh_key}"
}

# Private IP Addresses
output "private_ips" {
  value = ["${google_compute_instance.instances.*.network_interface.0.address}"]
}

# Public IP Addresses
output "public_ips" {
  value = ["${google_compute_instance.instances.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}

# Instance Target Pool
output "target_pool" {
  value = "${google_compute_target_pool.instances.self_link}"
}

# GCP Instance Self Link
output "instances_self_link" {
  value = ["${google_compute_instance.instances.*.self_link}"]
}

# Preemptible Scheduling (bool)
output "scheduling_preemptible" {
  value = "${var.scheduling_preemptible}"
}
