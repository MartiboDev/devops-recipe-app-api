terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }

  backend "s3" {
    bucket               = "martibo-recipe-app-tf-state"
    key                  = "tf-state-deploy"
    workspace_key_prefix = "tf-state-deploy-env"
    region               = "ap-southeast-2"
    encrypt              = true
    dynamodb_table       = "devops-recipe-app-api-tf-lock"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManageBy    = "Terraform/deploy"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}