# labDevOps
Projeto para utilização do Terraform para provisionar ambiente GCP (Google Cloud Platform).

`main.tf` arquivo responsável pelo template a ser provisionado, nele é apontado credential para utilização da Cloud, chave ssh para se conectar nas máquinas provisionadas, Regras de Firewall a serem criadas.

`terraform.tfstate` arquivote responsável pelo estado do ambiente provisionado ``deve ser antido com muito CUIDADO`` a ausência deste arquivo implica na impotência da m     antenabilidade do seu ambiente.

`startup.sh` script responsável para atualização e instalação de alguns pacotes após a execução do startup scriptxxxxcxc    