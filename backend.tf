terraform {
  backend "s3" {
    bucket       = "real-state-terraform-state-bucket"              # Seu nome de bucket S3
    key          = "terraform-backend-management/terraform.tfstate" # Caminho para o arquivo de estado deste projeto no bucket
    region       = "us-east-1"                                      # A região do seu bucket
    encrypt      = true
    use_lockfile = true
  }
}
