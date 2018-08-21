provider "google" {
  project = "${var.project_id}"
  region      = "${var.region}"
}

resource "google_compute_target_pool" "instances" {
  name           = "${format(var.hostname_format, 0, var.name_prefix)}"
  description = "DC/OS Instance Group"

  instances = [
    "${google_compute_instance.instances.*.self_link}"
  ]

#  region = "${var.region}"

}

resource "google_compute_instance" "instances" {
  count          = "${var.num_instances}"
  name           = "${format(var.hostname_format, count.index + 1, var.name_prefix)}"
  machine_type   = "${var.machine_type}"
  can_ip_forward = false
  zone           = "${element(var.zone_list, count.index)}"

  boot_disk {
    initialize_params {
      image = "${var.image}"
      size  = "${var.disk_size}"
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
    sshKeys   = "${var.ssh_user}:${file(var.public_ssh_key)}"
  }
}
