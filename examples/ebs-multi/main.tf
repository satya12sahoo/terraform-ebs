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

module "ebs_multi" {
  source = "../../modules/ebs-multi"

  default_tags = var.default_tags
  volumes      = var.volumes
}

output "volume_ids" {
  value = module.ebs_multi.volume_ids
}