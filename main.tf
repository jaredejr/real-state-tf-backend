resource "aws_s3_bucket" "terraform_state_storage" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Terraform State Storage"
    Environment = "Backend"
    ManagedBy   = "Terraform"
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

resource "aws_dynamodb_table" "terraform_state_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S" # S para String
  }

  tags = {
    Name        = "Terraform State Locks"
    Environment = "Backend"
    ManagedBy   = "Terraform"
  }
}