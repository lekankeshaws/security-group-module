

#########################################################
# TERRAFORM BLOCK
#########################################################

terraform {
  required_version = ">=1.1.0"

  backend "s3" {
    bucket         = "backend-0201-lekan-kesh-buck"
    key            = "path/env"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#########################################################
# PROVIDER BLOCK
#########################################################

provider "aws" {
  region  = "us-east-1"
  profile = "iamadmin"

}

#########################################################
# MODULE BLOCK
#########################################################

module "sg" {
  source = "../.."

  vpc_id    = data.aws_vpc.default.id
  component_name = var.component_name

  security_group_name = {    
      alb_sg = {
        name        = "${var.component_name}_alb_sg"
        description = "allow http and https to the alb"
      }
      webserver_sg = {
        name        = "${var.component_name}_webserver_security_group"
        description = "allow alb on port 80"
      }
      remote_access_sg = {
        name        = "${var.component_name}_bastion_security_group"
        description = "allow access to ssh"
      }
      database_sg = {
        name        = "${var.component_name}_database_security_group"
        description = "allow access on database port"
      }
    
  } 

}

data "aws_vpc" "default" {
  default = true
    
}

