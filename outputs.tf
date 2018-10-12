# Number of Instance
output "num_instances" {
  description = "num instances"
  value       = "${var.num_instances}"
}

# Cluster Name
output "name_prefix" {
  description = "Cluster Name"
  value       = "${var.cluster_name}"
}

# Instance Type
output "machine_type" {
  description = "machine type"
  value       = "${var.machine_type}"
}

# DCOS Version for prereq install
output "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
  value       = "${var.dcos_version}"
}

# Tested OSes to install with prereq
output "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  value       = "${var.dcos_instance_os}"
}

# Element by zone list
output "zone_list" {
  description = "zone list"
  value       = "${var.zone_list}"
}

# Source image to boot from
output "image" {
  description = "image"
  value       = "${var.image}"
}

# Disk Type to Leverage
output "disk_type" {
  description = "Disk Type to Leverage. The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional)"
  value       = "${var.disk_type}"
}

# Disk Size in GB
output "disk_size" {
  description = "disk size"
  value       = "${var.disk_size}"
}

# Instance Subnetwork Name
output "instance_subnetwork_name" {
  description = "instance subnetwork name"
  value       = "${var.instance_subnetwork_name}"
}

# Customer Provided Userdata
output "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  value       = "${var.user_data}"
}

# SSH User
output "ssh_user" {
  description = "ssh user"
  value       = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}"
}

# SSH Public Key
output "public_ssh_key" {
  description = "public ssh key"
  value       = "${var.public_ssh_key}"
}

# Allow stopping for update (bool)
output "allow_stopping_for_update" {
  description = "If true, allows Terraform to stop the instance to update its properties"
  value       = "${var.allow_stopping_for_update}"
}

# Private IP Addresses
output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${google_compute_instance.instances.*.network_interface.0.address}"]
}

# Public IP Addresses
output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${google_compute_instance.instances.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}

# GCP Instance Self Link
output "instances_self_link" {
  description = "List of instance self links"
  value       = ["${google_compute_instance.instances.*.self_link}"]
}

# Preemptible Scheduling (bool)
output "scheduling_preemptible" {
  description = "scheduling preemptible"
  value       = "${var.scheduling_preemptible}"
}

# Returns the ID of the prereq script (if user_data or ami are not used)
output "prereq_id" {
  description = "prereq id"
  value       = "${join(",", flatten(list(null_resource.instance-prereq.*.id)))}"
}
