provider "aws" {
  region = "eu-central-1"
}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "lwolynski-terraform"
#  versioning {
#    enabled = true
#  }
#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm = "AES256"
#      }
#    }
#  }
#}

#resource "aws_dynamodb_table" "terraform_locks" {
#  name         = "terraform-locks"
#  billing_mode = "PAY_PER_REQUEST"
#  hash_key     = "LockID"
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}

#terraform {
#  backend "s3" {
#    # Replace this with your bucket name!
#    bucket = "lwolynski-terraform"
#    key    = "global/s3/terraform.tfstate"
#    region = "eu-central-1"
# Replace this with your DynamoDB table name!
#    dynamodb_table = "terraform-locks"
#    encrypt        = true
#  }
#}
