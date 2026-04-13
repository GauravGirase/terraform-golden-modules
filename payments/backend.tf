terraform {
  backend "s3" {
    bucket         = "org-terraform-state-13042026"
    key            = "payments/prod/s3.tfstate"
    region         = "ap-south-1"
    encrypt = true
  }
}
