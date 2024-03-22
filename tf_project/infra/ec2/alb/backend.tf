terraform {
  backend "s3" {
    bucket         = "aws18-terraform-state"
    region         = "ap-northeast-2"
    key            = "infra/ec2/alb/terraform.tfstate"
    dynamodb_table = "aws18-terraform-looks"
    encrypt        = true
  }
}