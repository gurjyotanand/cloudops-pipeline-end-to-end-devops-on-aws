provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state_file" {
  bucket = "gurjyot-anand-tf-state-file"
  force_destroy = true
  tags = {
    name = "Terraform-State-File-Bucket"
  }
}

resource "aws_s3_bucket_versioning" "tf_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_file.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_bucket_sse" {
  bucket = aws_s3_bucket.terraform_state_file.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_db_lock" {
  name = "terraform-db-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name = "Teraaform-State-File-Lock"
  }
}
