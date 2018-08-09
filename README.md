# DC/OS Instances

Creates generic instances for DC/OS nodes

## Usage

```hcl
module "masters" {
  source  = "dcos-terraform/instance/gcp"
  version = "~> 0.0"

  providers = {
    google = "google"
  }

  cluster_name             = "${var.cluster_name}"
  hostname_format          = "${var.hostname_format}"
  num                      = "${var.num_masters}"
  image                    = "${coalesce(var.image, module.dcos-tested-oses.gcp_image_name)}"
  user_data                = "${var.image == "" ? module.dcos-tested-oses.os-setup : var.gcp_user_data}"
  machine_type             = "${var.machine_type}"
  instance_subnetwork_name = ["${var.master_subnetwork_name}"]
  ssh_user                 = "${var.ssh_user}"
  public_ssh_key           = "${var.public_ssh_key}"
  zone_list                = "${var.zone_list}"
  disk_type                = "${var.disk_type}"
  disk_size                = "${var.disk_size}"
  tags                     = "${var.tags}"
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
