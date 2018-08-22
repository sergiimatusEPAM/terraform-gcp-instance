provider "google" {}


locals {
    private_key = "${file(var.ssh_private_key_filename)}"
    agent = "${var.ssh_private_key_filename == "/dev/null" ? true : false}"
}


module "dcos-tested-oses" {
#  source  = "dcos-terraform/gcp-tested-oses/template"
#  version = "~> 0.0"

  source  = "../terraform-gcp-tested-oses"

  providers = {
    google = "google"
  }

  os = "${var.dcos_instance_os}"
  dcos_version = "${var.dcos_version}"
}

resource "google_compute_target_pool" "instances" {
  name        = "${format(var.hostname_format, 0, var.name_prefix)}"
  description = "DC/OS Instance Group"

  instances = [
    "${google_compute_instance.instances.*.self_link}",
  ]
}

resource "google_compute_instance" "instances" {
  count          = "${var.num_instances}"
  name           = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
  machine_type   = "${var.machine_type}"
  can_ip_forward = false
  zone           = "${element(var.zone_list, count.index)}"

  boot_disk {
    initialize_params {
      image = "${coalesce(var.image, module.dcos-tested-oses.gcp_image_name)}"
      #iimage = "${coalesce(var.image, module.dcos-tested-oses.gcp_image_name[count.index])}"
      type  = "${var.disk_type}"
    }

    auto_delete = true
  }

  network_interface {
    subnetwork = "${var.instance_subnetwork_name}"

    access_config = {
      // Ephemeral IP
    }
  }

  tags = ["${var.tags}", "${format(var.hostname_format, count.index + 1, var.name_prefix)}"]

  metadata = {
    user-data = "${var.user_data}"
    sshKeys   = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}:${file(var.public_ssh_key)}"
  }

  
    # OS init script
    provisioner "file" {
     content = "${module.dcos-tested-oses.os-setup}"
     destination = "/tmp/os-setup.sh"

  connection {
    user = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}"
    private_key = "${local.private_key}"
    agent = "${local.agent}"
  }
     }
  
   # We run a remote provisioner on the instance after creating it.
    # In this case, we just install nginx and start it. By default,
    # this should be on port 80
      provisioner "remote-exec" {
      inline = [
        "sudo chmod +x /tmp/os-setup.sh",
        "sudo bash /tmp/os-setup.sh",
      ]

  connection {
    user = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}"
    private_key = "${local.private_key}"
    agent = "${local.agent}"
  }
    }
  
    lifecycle {
      ignore_changes = ["labels.Name", "labels.cluster"]
    }
  

    scheduling {
      preemptible = "${var.gcp_scheduling_preemptible}"
      automatic_restart = "false"
    }
}
