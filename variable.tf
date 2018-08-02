# Number of Instance
variable "num_instances" {}

# Cluster Name
variable "cluster_name" {}

# Region
variable "region" {}

# Instance Type
variable "machine_type" {}

# Element by zone list
variable "zone_list" {}

# Source image to boot from
variable "customer_image" {}

# Disk Type to Leverage
variable "disk_type" {}

# Disk Size in GB
variable "disk_size" {}

# Instance Subnetwork Name
variable "instance_subnetwork_name" {}

# Customer Provided Userdata
variable "customer_userdata_rendered" {}

# SSH User
variable "ssh_user" {}

# SSH Public Key
variable "public_ssh_key" {}
