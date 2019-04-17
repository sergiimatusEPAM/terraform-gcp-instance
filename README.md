[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-instance/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-instance/job/master/)
# DC/OS Instances

Creates generic instances for DC/OS nodes

## Usage

```hcl
module "masters" {
  source  = "dcos-terraform/instance/gcp"
  version = "~> 0.1.0"

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
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| dcos\_instance\_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | n/a | yes |
| dcos\_version | Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list. | string | n/a | yes |
| disk\_size | Disk Size in GB | string | n/a | yes |
| disk\_type | Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional) | string | n/a | yes |
| image | Source image to boot from | string | n/a | yes |
| instance\_subnetwork\_name | Instance Subnetwork Name | string | n/a | yes |
| machine\_type | Instance Type | string | n/a | yes |
| num\_instances | How many instances should be created | string | n/a | yes |
| public\_ssh\_key | SSH Public Key | string | n/a | yes |
| ssh\_user | SSH User | string | n/a | yes |
| user\_data | User data to be used on these instances (cloud-init) | string | n/a | yes |
| zone\_list | Element by zone list | list | n/a | yes |
| allow\_stopping\_for\_update | If true, allows Terraform to stop the instance to update its properties | string | `"true"` | no |
| hostname\_format | Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-instance%[1]d-%[2]s"` | no |
| labels | Add custom labels to all resources | map | `<map>` | no |
| scheduling\_preemptible | Deploy instance with preemptible scheduling. (bool) | string | `"false"` | no |
| ssh\_private\_key\_filename | Path to the SSH private key | string | `"/dev/null"` | no |
| tags | Add custom tags to all resources | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| allow\_stopping\_for\_update | If true, allows Terraform to stop the instance to update its properties |
| dcos\_instance\_os | Operating system to use. Instead of using your own AMI you could use a provided OS. |
| dcos\_version | Specifies which DC/OS version instruction to use. Options: 1.12.3, 1.11.10, etc. See dcos_download_path or dcos_version tree for a full list. |
| disk\_size | Disk Size in GB |
| disk\_type | Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional) |
| image | Source image to boot from |
| instance\_subnetwork\_name | Instance Subnetwork Name |
| instances\_self\_link | List of instance self links |
| machine\_type | Instance Type |
| name\_prefix | Name Prefix |
| num\_instances | How many instances should be created |
| prereq\_id | Prereq id used for dependency |
| private\_ips | List of private ip addresses created by this module |
| public\_ips | List of public ip addresses created by this module |
| public\_ssh\_key | SSH Public Key |
| scheduling\_preemptible | Deploy instance with preemptible scheduling. (bool) |
| ssh\_user | SSH User |
| user\_data | User data to be used on these instances (cloud-init) |
| zone\_list | Element by zone list |

