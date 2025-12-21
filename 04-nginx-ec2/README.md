# Nginx EC2 Layer

Deploys EC2 instances using the Nginx AMI built with Packer.

## Prerequisites

1. Network layer deployed (`01-network`)
2. Nginx AMI built and AMI ID stored in SSM at `/${project_name}/${environment}/nginx-ami-id`

## Usage

```bash
terraform init
terraform plan -var-file="envs/dev/nginx-ec2.tfvars"
terraform apply
```

## Configuration

Configure nginx server blocks via `user_data`:

```bash
user_data = <<-EOF
  #!/bin/bash
  cat > /etc/nginx/conf.d/default.conf <<'NGINX_EOF'
  server {
      listen 80;
      server_name example.com;
      location / {
          proxy_pass http://backend:8080;
      }
  }
  NGINX_EOF
  nginx -t && systemctl reload nginx
EOF
```

## Access

Connect via SSM Session Manager:
```bash
aws ssm start-session --target <instance-id>
```

## Outputs

- `instance_id` - EC2 instance ID
- `instance_private_ip` - Private IP address (instances are in private subnet, accessed via ALB/ELB)
