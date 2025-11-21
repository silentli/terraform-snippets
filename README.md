# Terraform Snippets

A collection of Terraform configurations following for AWS infrastructure management.

## Project Structure

```
├── 00-bootstrap/          # Foundation layer (OIDC, IAM, S3 backend)
├── 01-network/           # Network layer (VPC, subnets, routing)
├── 02-ec2-creation/      # Compute layer (EC2 instances)
├── cost-governance/      # AWS Budgets for cost monitoring
├── modules/              # Reusable Terraform modules
├── envs/                 # Environment-specific variables
└── .github/workflows/    # GitHub Actions CI/CD
```

## Architecture

### **Foundation Layer (00-bootstrap)**
- **OIDC Provider**: GitHub Actions authentication
- **IAM Roles**: Separate roles for each layer
- **S3 Backend**: Remote state storage
- **Backend Generator**: Creates backend configs for other layers

### **Network Layer (01-network)**
- **VPC**: Virtual Private Cloud
- **Subnets**: Public and private subnets
- **Internet Gateway**: Internet connectivity
- **Route Tables**: Routing configuration

### **Compute Layer (02-ec2-creation)**
- **EC2 Instances**: Virtual machines
- **Security Groups**: Network security
- **Uses Network**: References network layer outputs

### **Cost Governance (cost-governance)**
- **AWS Budgets**: Tracks spend by project/environment tags
- **Alerts**: Sends notifications to configured email recipients

## Quick Start

1. **Deploy Foundation**:
   ```bash
   cd 00-bootstrap
   terraform init
   terraform plan -var-file="../envs/dev/bootstrap.tfvars"
   terraform apply -var-file="../envs/dev/bootstrap.tfvars"
   ```

2. **Deploy Network**:
   ```bash
   cd 01-network
   terraform init
   terraform plan -var-file="../envs/dev/network.tfvars"
   terraform apply -var-file="../envs/dev/network.tfvars"
   ```

3. **Deploy Compute**:
   ```bash
   cd 02-ec2-creation
   terraform init
   terraform plan -var-file="../envs/dev/ec2-compute.tfvars"
   terraform apply -var-file="../envs/dev/ec2-compute.tfvars"
   ```

4. **(Optional) Deploy Cost Governance**:
   ```bash
   cd cost-governance
   terraform init
   terraform plan -var-file="../envs/dev/cost-governance.tfvars"
   terraform apply -var-file="../envs/dev/cost-governance.tfvars"
   ```

## GitHub Actions

Workflows are configured for automated deployment:
- **Bootstrap**: Foundation infrastructure
- **Network**: VPC and networking
- **Compute**: EC2 instances

## Environment Files

Copy example files and customize:
- `envs/dev/bootstrap.tfvars.example` → `envs/dev/bootstrap.tfvars`
- `envs/dev/network.tfvars.example` → `envs/dev/network.tfvars`
- `envs/dev/ec2-compute.tfvars.example` → `envs/dev/ec2-compute.tfvars`
- `envs/dev/cost-governance.tfvars.example` → `envs/dev/cost-governance.tfvars`

See `envs/README.md` for detailed setup instructions, including the optional cost governance layer.

## Code Quality

**TFLint**: Lint all Terraform code with a single command:
```bash
./scripts/tflint.sh
```

Uses the root `.tflint.hcl` config for consistent rules across all projects and modules. See `docs/tflint.md` for details.

## Security Features

- **OIDC Authentication**: No long-lived credentials
- **Least Privilege**: Granular IAM permissions
- **Encrypted State**: AES256 encryption
- **Network Isolation**: VPC with public/private subnets
