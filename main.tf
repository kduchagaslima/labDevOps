provider "google" {
  credentials = "${file("/home/celima/.credentials/gcp-terraform-credential.json")}"
  project     = "terraform-project-285517"
  region      = "us-central1"
  zone        = "us-central1-c"
}
resource "google_compute_instance_template" "default"{
  name = "teste-terraform"
  description = "Template utilizado para POC do Terraform com o GCP"
  metadata_startup_script = "${file("/home/celima/ansibleTerraform/startup.sh")}"
  labels = {
    "environment" = "lab"
  }

  machine_type = "n1-standard-1"
  can_ip_forward = false  
  scheduling {
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }
// Create a new boot disk from ma image
  disk {
    source_image = "centos-8-v20200714"
    auto_delete = true
    boot = true
  }  

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }    
  }
// Adding a ssh Key
  metadata = {
    sshKeys = join("",["celima:",file("/home/celima/.ssh/id_rsa.pub")])
    }
}  
resource "google_compute_instance_group_manager" "teste-terraform" {
  name = "laboratorio"
  base_instance_name = "lab-terraform"
  zone = "us-central1-c"
  target_size = 10
  version {
    instance_template = "${google_compute_instance_template.default.self_link}"
  }
     
}
# Cria regras de Firewall para a VM criada
resource "google_compute_firewall" "webfirewall" {
  name = "rule-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [22,8080]
  }
}
