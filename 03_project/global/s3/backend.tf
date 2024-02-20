terraform {
  backend "s3" {
    bucket         = "aws18-terraform-state"
    region         = "ap-northeast-2"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "aws18-terraform-looks"
    encrypt        = true
  }
}