data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "project05-bucket-terraform"
    key = "infra/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}