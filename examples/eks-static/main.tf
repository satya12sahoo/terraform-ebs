terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ebs" {
  source = "../../modules/ebs"

  name               = var.name
  tags               = var.tags

  availability_zone  = var.availability_zone
  size               = var.size

  enable_attachment  = false
}

output "volume_id" {
  value       = module.ebs.volume_id
  description = "EBS volume ID for the static PV."
}

output "availability_zone" {
  value       = module.ebs.availability_zone
  description = "AZ of the EBS volume."
}