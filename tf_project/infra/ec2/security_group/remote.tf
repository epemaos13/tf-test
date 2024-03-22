data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "aws18-terraform-state"
    key    = "infra/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}