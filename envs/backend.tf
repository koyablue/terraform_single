terraform {
  backend "s3" {
    bucket = "test-terraform-123"
    key    = "terraform/production.tfstate"
    region = "ap-northeast-1"
  }
}
