variable "aws_region" {
  description = "A região AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "O nome do bucket S3 para armazenar os estados do Terraform. Deve ser globalmente único."
  type        = string
  # Exemplo: "meu-tf-backend-estados-12345"
  # É recomendado adicionar um sufixo aleatório ou identificador de conta para garantir a unicidade.
}

variable "dynamodb_table_name" {
  description = "O nome da tabela DynamoDB para o bloqueio de estado do Terraform."
  type        = string
  # Exemplo: "meu-tf-backend-locks"
}