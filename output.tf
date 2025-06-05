output "s3_bucket_name" {
  description = "O nome do bucket S3 criado para armazenar os estados do Terraform."
  value       = aws_s3_bucket.terraform_state_storage.bucket
}

output "dynamodb_table_name" {
  description = "O nome da tabela DynamoDB criada para o bloqueio de estado do Terraform."
  value       = aws_dynamodb_table.terraform_state_locks.name
}