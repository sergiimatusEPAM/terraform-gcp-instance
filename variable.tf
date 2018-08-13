# Number of Instance
variable "num_instances" {}

# Cluster Name
variable "cluster_name" {}

# Instance Type
variable "machine_type" {}

# Element by zone list
variable "zone_list" {
  type    = "list"
  default = []
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

# Format the hostname inputs are index+1, region, cluster_name
variable "hostname_format" {
  default = "%[3]s-instance%[1]d-%[2]s"
}
