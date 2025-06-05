resource "aws_s3_bucket" "terraform_state_storage" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Terraform State Storage"
    Environment = "Backend"
    ManagedBy   = "Terraform"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_storage_versioning" {
  bucket = aws_s3_bucket.terraform_state_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_storage_encryption" {
  bucket = aws_s3_bucket.terraform_state_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_storage_public_access" {
  bucket = aws_s3_bucket.terraform_state_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}