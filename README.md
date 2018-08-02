# DC/OS Instances

Creates generic instances for DC/OS nodes

## Usage

```hcl
module "masters" {
  source = "../terraform-gcp-instances"

  # version = "0.0.0"

  num_instance                   = "${var.instances_count}"
  disk_size                      = "${var.gcp_instances_disk_size}"
  disk_type                      = "${var.gcp_instances_disktype}"
  region                         = "${var.gcp_region}"
  machine_type                   = "${var.gcp_instances_gce_type}"
  cluster_name                   = "${var.cluster_name}"
  public_ssh_key                 = "${var.gcp_ssh_key}"
  instances_subnetwork_name      = "${module.network.instances_subnetwork_name}"
  instances_targetpool_self_link = "${module.network.instances_targetpool_self_link}"
  customer_image                 = "${var.image}"
  region                         = "${var.gcp_region}"
  zone_list                      = "${data.google_compute_zones.available.names}"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster_name | Cluster Name | string | - | yes |
| customer_image | Source image to boot from | string | - | yes |
| customer_userdata_rendered | Customer Provided Userdata | string | - | yes |
| disk_size | Disk Size in GB | string | - | yes |
| disk_type | Disk Type to Leverage | string | - | yes |
| instance_subnetwork_name | Instance Subnetwork Name | string | - | yes |
| machine_type | Instance Type | string | - | yes |
| num_instances | Number of Instance | string | - | yes |
| public_ssh_key | SSH Public Key | string | - | yes |
| region | Region | string | - | yes |
| ssh_user | SSH User | string | - | yes |
| zone_list | Element by zone list | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_name | Cluster Name |
| customer_image | Source image to boot from |
| customer_userdata_rendered | Customer Provided Userdata |
| disk_size | Disk Size in GB |
| disk_type | Disk Type to Leverage |
| instance_private_ip_addresses | Private IP Addresses |
| instance_public_ip_addresses | Public IP Addresses |
| instance_subnetwork_name | Instance Subnetwork Name |
| machine_type | Instance Type |
| num_instances | Number of Instance |
| public_ssh_key | SSH Public Key |
| region | Region |
| ssh_user | SSH User |
| zone_list | Element by zone list |
