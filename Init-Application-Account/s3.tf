resource "random_string" "random" {
  count            = 3
  length           = 8
  special          = false
  upper            = false
}

resource "aws_s3_bucket" "terraform" {
  bucket = "terraform-application-account-${random_string.random[0].result}"

}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.terraform.id
  acl    = "private"
}


resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = aws_s3_bucket.terraform.id
}