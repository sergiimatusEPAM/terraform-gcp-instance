# Number of Instance
variable "num_instances" {
  description = "How many instances should be created"
}

# Cluster Name
variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

# Instance Type
variable "machine_type" {
  description = "Instance Type"
}

# DCOS Version for prereq install
variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
}

# Tested OSes to install with prereq
variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
}

# Private SSH Key Filename Optional
variable "ssh_private_key_filename" {
  description = "Path to the SSH private key"

  # cannot leave this empty as the file() interpolation will fail later on for the private_key local variable
  # https://github.com/hashicorp/terraform/issues/15605
  default = "/dev/null"
}

# Element by zone list
variable "zone_list" {
  description = "Element by zone list"
  type        = "list"
}

# Source image to boot from
variable "image" {
  description = "Source image to boot from"
}

# Disk Type to Leverage. The GCE disk type. Can be either "pd-ssd", "local-ssd", or "pd-standard". (optional)
variable "disk_type" {
  description = "Disk Type to Leverage"
}

# Disk Size in GB
variable "disk_size" {
  description = "Disk Size in GB"
}

# Instance Subnetwork Name
variable "instance_subnetwork_name" {
  description = "Instance Subnetwork Name"
}

# Customer Provided Userdata
variable "user_data" {
  description = "User data to be used on these instances (cloud-init)"
}

# SSH User
variable "ssh_user" {
  description = "SSH User"
}

# SSH Public Key
variable "public_ssh_key" {
  description = "SSH Public Key"
}

# Allow stopping for update (bool)
variable "allow_stopping_for_update" {
  description = "If true, allows Terraform to stop the instance to update its properties"
  default     = "true"
}

# Add special tags to the resources created by this module
variable "tags" {
  type        = "list"
  description = "Add custom tags to all resources"
  default     = []
}

variable "labels" {
  description = "Add custom labels to all resources"
  type        = "map"
  default     = {}
}

# Format the hostname inputs are index+1, region, name_prefix
variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "%[3]s-instance%[1]d-%[2]s"
}

# Deploy instance with preemptible scheduling. (bool)
variable "scheduling_preemptible" {
  description = "Deploy instance with preemptible scheduling. (bool)"
  default     = "false"
}
