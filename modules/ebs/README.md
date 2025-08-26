# EBS Terraform Module

Reusable module to create and optionally attach an AWS EBS volume with flexible tagging and settings.

## Usage

Create a `terraform.tfvars` (or use `-var-file`) and pass inputs. Example usage:

```hcl
provider "aws" {
  region = var.region
}

module "ebs" {
  source = "../../modules/ebs"

  name               = var.name
  environment        = var.environment
  project            = var.project
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
```

See `examples/ebs-basic/terraform.tfvars.example` for a full set of example inputs.

## Inputs (highlights)
- `name` (string): Name tag. Required
- `availability_zone` (string): AZ where to create the volume. Required
- `size` (number): GiB size (or set `snapshot_id`)
- `type` (string): gp3 (default), gp2, io1, io2, st1, sc1, standard
- `iops` (number): Required for io1/io2; optional for gp3
- `throughput` (number): gp3 only
- `encrypted` (bool): Default true; `kms_key_id` optional
- `tags` (map(string)): Extra tags
- Attachment: set `enable_attachment=true` and provide `instance_id` and `device_name`

## Outputs
- `volume_id`
- `arn`
- `availability_zone`
- `size`
- `type`
- `iops`
- `throughput`
- `tags`
- `attachment_id`