resource "aws_s3_bucket" "project05-bucket-terraform" {
  bucket = "project05-bucket-terraform"

  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true

  tags = {
    Name = "project05-bucket-terraform"
  }
}

resource "aws_dynamodb_table" "project05-terraform-locks" {
  name = "project05-terraform-looks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}