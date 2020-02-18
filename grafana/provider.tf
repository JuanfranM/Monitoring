# REMOTE STATE CONFIGURE
terraform {
  backend "s3" {
    bucket = "NOMBRE-BUCKET-S3"
    key    = "states/grafana_terraform.tfstate"
    region = "eu-west-1"
  }
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "NOMBRE-BUCKET-S3"
    key    = "states/vpc_terraform.tfstate"
    region = "eu-west-1"
  }
}

################################
## CONFIGURATION AWS PRIVIDER ##
################################
provider "aws" {
  version = "~> 2.8"
  region  = var.region
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

#################################
## DATA SELECTION AWS INSTANCE ##
#################################
data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
  owners = ["amazon"] #Canonical
}
