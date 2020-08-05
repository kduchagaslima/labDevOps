provider "google" {
  credentials = "${file("/home/celima/.credentials/gcp-terraform-credential.json")}"
  project     = "terraform-project-285517"
  region      = "us-central1"
  zone        = "us-central1-c"
}
resource "google_compute_instance_template" "vm_instance"{
  name = "teste-terraform"
  machine_type = "n1-standard-1"
  metadata_startup_script = "yum update && yum install -y ansible"
  
  network_interface{
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
      nat_ip = "${google_compute_address.static.address}"
    }     
  }
  disk {
    source_image = "centos-8-v20200714"
    auto_delete = true
    boot = true
  }  
resource "google_compute_address" "static" {
  name = "ipv4-address"
}
resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}
resource "google_compute_instance_group_manager" "teste-terraform" {
  name = "laboratorio"
  base_instance_name = "lab-terraform"
  zone = "us-central1-c"
  target_size = 3
  version {
    instance_template = "${google_compute_instance_template.vm_instance.self_link}"
  }   
}
# Cria o Firewall para a VM
resource "google_compute_firewall" "webfirewall" {
  name = "rule-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [22]
  }
}
}