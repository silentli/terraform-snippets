# Terraform Snippets

A collection of Terraform configurations following for AWS infrastructure management.

## Project Structure

```
├── 00-bootstrap/          # Foundation layer (OIDC, IAM, S3 backend)
├── 01-network/           # Network layer (VPC, subnets, routing)
├── 02-ec2-creation/      # Compute layer (EC2 instances)
├── 03-packer-iam/        # IAM roles for Packer AMI builds
├── 04-nginx-ec2/         # Nginx instances (Launch Template + ASG)
├── cost-governance/      # AWS Budgets for cost monitoring
├── modules/              # Reusable Terraform modules
├── envs/                 # Environment-specific variables
└── packer/               # Packer configurations for AMI builds
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

### **Nginx Layer (04-nginx-ec2)**
- **Launch Template**: EC2 launch configuration with IAM instance profile
- **Auto Scaling Group**: Scalable instance management
- **AMI Integration**: Uses Packer-built AMI from SSM Parameter Store
- **Security Groups**: HTTP/HTTPS access controls
- **Uses Network**: Deploys to private subnets

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

4. **Deploy Nginx (after Packer AMI build)**:
   ```bash
   cd 04-nginx-ec2
   terraform init
   terraform plan -var-file="../envs/dev/nginx-ec2.tfvars"
   terraform apply -var-file="../envs/dev/nginx-ec2.tfvars"
   ```

5. **(Optional) Deploy Cost Governance**:
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
- **Nginx**: Launch template and ASG deployment

## Environment Files

Copy example files and customize:
- `envs/dev/bootstrap.tfvars.example` → `envs/dev/bootstrap.tfvars`
- `envs/dev/network.tfvars.example` → `envs/dev/network.tfvars`
- `envs/dev/ec2-compute.tfvars.example` → `envs/dev/ec2-compute.tfvars`
- `envs/dev/nginx-ec2.tfvars.example` → `envs/dev/nginx-ec2.tfvars`
- `envs/dev/cost-governance.tfvars.example` → `envs/dev/cost-governance.tfvars`

See `envs/README.md` for detailed setup instructions.

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
