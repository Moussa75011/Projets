terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("stream-projet-8b2fcff3752c.json")

  project = "stream-projet"
  region  = "us-east1"
  zone    = "us-east1-d"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  allow_stopping_for_update = true
  machine_type = "e2-micro"

  tags         = ["stream", "test"]

  boot_disk {
    initialize_params {
     //image = "debian-cloud/debian-11"
     image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

