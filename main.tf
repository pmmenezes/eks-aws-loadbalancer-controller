terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
}



provider "helm" {
  # Configuration options
}

provider "aws" {
  region = var.aws_region
  profile = "dafault"
#  access_key = "my-access-key"
#  secret_key = "my-secret-key"
}


##############################
## Para uso de state remoto ##
##############################
#terraform {
#  backend "s3" {
#    bucket = "bucket_name"
#    key = "tf/terraform.tfstate"
#    region  = "region"
#    dynamodb_table = "name_dunamodb_table"
#    encrypt = true
#    profile = "default"
#  } 
#}


