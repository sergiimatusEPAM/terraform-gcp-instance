# Number of Instance
output "num_instances" {
  value = "${var.num_instances}"
}
# Cluster Name
output "cluster_name" {
  value = "${var.cluster_name}"
}

# Region
output "region" {
  value = "${var.region}"
}

# Instance Type
output "machine_type" {
  value = "${var.machine_type}"
}

# Element by zone list
output "zone_list" {
  value = "${var.zone_list}"
}

# Source image to boot from
output "customer_image" {
  value = "${var.customer_image}"
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
output "customer_userdata_rendered" {
  value = "${var.customer_userdata_rendered}"
}

# SSH User
output "ssh_user" {
  value = "${var.ssh_user}"
}

# SSH Public Key
output "public_ssh_key" {
  value = "${var.public_ssh_key}"
}

# Private IP Addresses
output "instance_private_ip_addresses" {
  value = ["${google_compute_instance.instances.*.network_interface.0.address}"]
}

# Public IP Addresses
output "instance_public_ip_addresses" {
  value = ["${google_compute_instance.instances.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}
