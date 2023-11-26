terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.1"
    }
  }
}

  backend "s3" {
    bucket = "jenkins-cicd-project"
    key    = "terraform/terraform.tfstate"
    region = "ap-southeast-1"
  }
provider "aws" {

  region = "ap-southeast-1"
}
