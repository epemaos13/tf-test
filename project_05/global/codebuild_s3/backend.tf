terraform {
  backend "s3" {
    bucket         = "project05-bucket-codebuild"
    region         = "ap-northeast-2"
    key            = "global/codebuild_s3/terraform.tfstate"
    dynamodb_table = "project05-codebuild-looks"
    encrypt        = true
  }
}