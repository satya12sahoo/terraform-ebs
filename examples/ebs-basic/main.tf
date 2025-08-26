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
  type               = var.type
  iops               = var.iops
  throughput         = var.throughput
  encrypted          = var.encrypted
  kms_key_id         = var.kms_key_id
  snapshot_id        = var.snapshot_id
  multi_attach_enabled = var.multi_attach_enabled
  outpost_arn        = var.outpost_arn

  enable_attachment  = var.enable_attachment
  instance_id        = var.instance_id
  device_name        = var.device_name
  force_detach       = var.force_detach
  skip_destroy       = var.skip_destroy
}

output "volume_id" {
  value = module.ebs.volume_id
}