# Number of Instance
variable "num_instances" {}

# Cluster Name
variable "name_prefix" {}

# Instance Type
variable "machine_type" {}

# DCOS Version for prereq install
variable "dcos_version" {}

# Tested OSes to install with prereq
variable "dcos_instance_os" {}

# Private SSH Key Filename Optional
variable "ssh_private_key_filename" { default = "/dev/null" }

# Element by zone list
variable "zone_list" {
  type = "list"
}

# Source image to boot from
variable "image" {}

# Disk Type to Leverage. The GCE disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". (optional)
variable "disk_type" {}

# Disk Size in GB
variable "disk_size" {}

# Instance Subnetwork Name
variable "instance_subnetwork_name" {}

# Customer Provided Userdata
variable "user_data" {}

# SSH User
variable "ssh_user" {}

# SSH Public Key
variable "public_ssh_key" {}

# Add special tags to the resources created by this module
variable "tags" {
  type    = "list"
  default = []
}

# Format the hostname inputs are index+1, region, name_prefix
variable "hostname_format" {
  default = "instance-%[1]d-%[2]s"
}

# Deploy instance with preemptible scheduling. (bool)
variable "gcp_scheduling_preemptible" {
  default = "true"
}
