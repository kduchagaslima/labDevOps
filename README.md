# labDevOps
Projeto para utilização do Terraform para provisionar ambiente GCP (Google Cloud Platform).

### `main.tf` 
arquivo responsável pelo template a ser provisionado, nele é apontado credential para utilização da Cloud, chave ssh para se conectar nas máquinas provisionadas, Regras de Firewall a serem criadas.

### `terraform.tfstate` 
arquivo responsável pelo estado do ambiente provisionado ``deve ser mantido com muito CUIDADO`` a ausência deste arquivo implica na impotência da m     antenabilidade do seu ambiente.

### `startup.sh` 
script responsável para atualização e instalação de alguns pacotes após a execução do startup script do próprio template do GCP.

### `post_config.yml` 
este playbook foi utilizado para gerenciar as máquinas via Ansible, nele é configurado quais são os pacotes que serão instalados na variável `"{{ package }}"` como no exmplo abaixo:
`````
    package: 
      - sos
      - cockpit-ws 
      - cockpit 
      - cockpit-system 
      - cockpit-storaged 
      - cockpit-packagekit 
      - cockpit-dashboard
      - cockpit-pcp
      - podman
      - git
      - neofetch
      - tcpdump
`````
### `credentials` 
Neste diretório colocamos a credential do projeto GCP em formato `json` e mencionar no arquivo `main.tf` conforme abaixo: 
`````
provider "google" {
  credentials = "${file("credentials/gcp-terraform-credential.json")}"
  project     = "littlecharlie-tech"
  region      = "us-central1"
  zone        = "us-central1-c"
}
`````
Adicionalmente inserimos também a chave ssh para acessar as máquinas provisionadas na nuvem, basta apontar neste trecho do `main.tf`
`````
  metadata = {
    sshKeys = join("",["celima:",file("credentials/id_rsa.pub")])
  }  
`````
### `templates` 
Neste diretório é colocado os templates utilizados nos playbooks Ansible