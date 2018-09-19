provider "google" {}

locals {
  private_key = "${file(var.ssh_private_key_filename)}"
  agent       = "${var.ssh_private_key_filename == "/dev/null" ? true : false}"
}

module "dcos-tested-oses" {
  source  = "dcos-terraform/gcp-tested-oses/template"
  version = "~> 0.0"

  providers = {
    google = "google"
  }

  os           = "${var.dcos_instance_os}"
  dcos_version = "${var.dcos_version}"
}

resource "google_compute_instance" "instances" {
  count                     = "${var.num_instances}"
  name                      = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
  machine_type              = "${var.machine_type}"
  can_ip_forward            = false
  zone                      = "${element(var.zone_list, count.index)}"
  allow_stopping_for_update = "${var.allow_stopping_for_update}"

  boot_disk {
    initialize_params {
      image = "${coalesce(var.image, module.dcos-tested-oses.image_name)}"
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

  lifecycle {
    ignore_changes = ["labels.Name", "labels.cluster"]
  }

  scheduling {
    preemptible       = "${var.scheduling_preemptible}"
    automatic_restart = "false"
  }
}

resource "null_resource" "instance-prereq" {
  # If the user supplies an AMI or user_data we expect the prerequisites are met.
  count = "${var.image == "" ? var.num_instances : 0}"

  connection {
    host        = "${element(google_compute_instance.instances.*.network_interface.0.access_config.0.assigned_nat_ip, count.index)}"
    user        = "${coalesce(var.ssh_user, module.dcos-tested-oses.user)}"
    private_key = "${local.private_key}"
    agent       = "${local.agent}"
  }

  provisioner "file" {
    content     = "${module.dcos-tested-oses.os-setup}"
    destination = "/tmp/dcos-prereqs.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dcos-prereqs.sh",
      "sudo bash -x /tmp/dcos-prereqs.sh",
    ]
  }

  depends_on = ["google_compute_instance.instances"]
}
