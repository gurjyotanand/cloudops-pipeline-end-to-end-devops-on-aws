terraform {
  backend "s3" {
    bucket         = "gurjyot-anand-tf-state-file" # Your bucket name
    key            = "cloudops-pipeline-end-to-end-devops-on-aws/terraform.tfstate" # Unique path for this project's state
    region         = "us-east-1" # Same region as your bucket
    encrypt        = true
    dynamodb_table = "terraform-db-state-lock" # Your DynamoDB table name
  }
}