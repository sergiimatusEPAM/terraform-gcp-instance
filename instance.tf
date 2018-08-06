resource "google_compute_instance" "instances" {
  count          = "${var.num_instances}"
  name           = "${var.cluster_name}-instance"
  region         = "${var.region}"
  machine_type   = "${var.machine_type}"
  can_ip_forward = false
  zone           = "${element(var.zone_list, count.index)}"

  disk {
    source_image = "${var.customer_image}"
    auto_delete  = true
    disk_type    = "${var.disk_type}"
    disk_size_gb = "${var.disk_size}"
  }

  network_interface {
    subnetwork = "${var.instance_subnetwork_name}"

    access_config = {
      // Ephemeral IP
    }
  }

  tags = ["${var.tags}", "${format(var.hostname_format, (count.index + 1), var.region, var.cluster_name)}"]

  metadata = {
    user-data = "${var.customer_userdata_rendered}"
    sshKeys   = "${var.ssh_user}:${file(var.public_ssh_key)}"
  }
}
