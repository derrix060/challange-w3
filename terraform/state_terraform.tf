
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "mario-terraform-remote-state-storage"
    region         = "ap-northeast-1"
    key            = "aws-state"
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "mario-terraform-state-storage" {
    bucket = "mario-terraform-remote-state-storage"

    # Enable versioning because might be good if need to rowback.
    versioning {
      enabled = true
    }

    # Prevent destroying remote state.
    lifecycle {
      prevent_destroy = true
    }
 
    tags = {
      Name = "S3 Remote Terraform State Store"
    }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
