# EKS Static Provisioning with AWS EBS CSI

This example shows how to create an EBS volume with Terraform and consume it in EKS using static provisioning (PV/PVC) with the EBS CSI driver.

## Steps
1) Create the EBS volume with Terraform:
```bash
cd examples/eks-static
terraform init
terraform apply -var-file=terraform.tfvars
```

2) Capture the volume ID and AZ:
```bash
VOL_ID=$(terraform output -raw volume_id)
AZ=$(terraform output -raw availability_zone 2>/dev/null || true)
```

3) Update the PV manifest with your values:
```bash
sed -i "s|vol-REPLACE_ME|$VOL_ID|" k8s/pv.yaml
[ -n "$AZ" ] && sed -i "s|us-east-1a|$AZ|" k8s/pv.yaml || true
```

4) Apply PV and PVC to your EKS cluster (ensure EBS CSI driver is installed):
```bash
kubectl apply -f k8s/pv.yaml
kubectl apply -f k8s/pvc.yaml
```

Notes:
- Keep `enable_attachment = false`; the CSI driver manages attachment/detachment.
- Ensure the PV AZ matches the EBS volume AZ and your worker nodes.