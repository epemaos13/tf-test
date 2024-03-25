resource "aws_s3_bucket" "project05-bucket-codebuild" {
  bucket = "project05-bucket-codebuild"

  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true

  tags = {
    Name = "project05-bucket-codebuild"
  }
}

resource "aws_dynamodb_table" "project05-codebuild-locks" {
  name = "project05-codebuild-looks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}