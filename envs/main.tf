//=============================================================================
// provider
//=============================================================================

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

//=============================================================================
// VPC module
//=============================================================================

module "vpc" {
  source       = "../modules/vpc"
  stage        = "production"
  project_name = var.project_name
  region       = var.region
}