terraform {
  backend "s3" {
    bucket         = "org-terraform-state"
    key            = "payments/prod/s3.tfstate"
    region         = "ap-south-1"
    encrypt = true
  }
}