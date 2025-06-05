output "s3_bucket_name" {
  description = "O nome do bucket S3 criado para armazenar os estados do Terraform."
  value       = aws_s3_bucket.terraform_state_storage.bucket
}
