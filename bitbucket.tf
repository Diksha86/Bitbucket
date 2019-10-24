provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

resource "google_compute_address" "bitbucketip" {
  name   = "${var.bitbucket_instance_ip_name}"
  region = "${var.bitbucket_instance_ip_region}"
}


resource "google_compute_instance" "bitbucket" {
  name         = "${var.instance_name}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "bitbucket", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.bitbucketvpc}"
    subnetwork = "${var.bitbucketsub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.bitbucketip.address}"
    }
  }
  metadata = {
    name = "bitbucket"
  }

  metadata_startup_script = "sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/Diksha86/bitbucket.git; cd bitbucket ; sudo chmod 777 *; sudo sh bitbucket.sh"
}
