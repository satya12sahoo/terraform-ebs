# EBS Terraform Module

Reusable module to create and optionally attach an AWS EBS volume with flexible settings and a single tags variable.

## Usage

Create a `terraform.tfvars` (or use `-var-file`) and pass inputs. Example usage:

```hcl
provider "aws" {
  region = var.region
}

module "ebs" {
  source = "../../modules/ebs"

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
- `availability_zone` (string): AZ where to create the volume. Required
- `size` (number): GiB size (or set `snapshot_id`)
- `type` (string): gp3 (default), gp2, io1, io2, st1, sc1, standard
- `iops` (number): Required for io1/io2; optional for gp3
- `throughput` (number): gp3 only
- `encrypted` (bool): Default true; `kms_key_id` optional
- `tags` (map(string)): Tags to assign to the volume
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

## Use in EKS with static provisioning

- Do not attach the EBS volume via Terraform. Set `enable_attachment = false`. The EBS CSI driver will attach/detach as pods are scheduled.
- Make sure the volume AZ matches your worker node AZs.
- Install the AWS EBS CSI driver on your cluster (see the AWS EKS docs: `https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html`).

### Steps
1) Create the EBS volume with this module:

```hcl
module "ebs" {
  source = "../../modules/ebs"

  availability_zone = "us-east-1a"
  size              = 20

  tags = {
    Name      = "app-data"
    ManagedBy = "terraform"
  }

  enable_attachment = false
}
```

2) Note the Terraform output `module.ebs.volume_id`.

3) Create a static PV and PVC that reference the EBS volume ID and the AZ:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ebs-pv-static
spec:
  capacity:
    storage: 20Gi
  volumeMode: Filesystem
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ""
  csi:
    driver: ebs.csi.aws.com
    volumeHandle: vol-0123456789abcdef0  # <- replace with Terraform output
    fsType: ext4
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: topology.kubernetes.io/zone
          operator: In
          values:
          - us-east-1a                   # <- match the volume AZ
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ebs-pvc-static
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
  storageClassName: ""
  volumeName: ebs-pv-static
```

- The PVC will bind to the PV, and the EBS CSI driver will handle node attachments automatically.