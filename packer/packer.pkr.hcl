# Packer Configuration for Nginx AMI
# This configuration builds an Amazon Linux 2 AMI with Nginx pre-installed and pre-configured

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Variables are defined in variables.pkr.hcl

# Data source for Amazon Linux 2 AMI
data "amazon-ami" "amazon_linux" {
  filters = {
    name                = "amzn2-ami-hvm-*-x86_64-gp2"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  region      = var.aws_region
}

# Build configuration
source "amazon-ebs" "nginx" {
  ami_name      = "${var.project_name}-${var.ami_name}-${var.environment}-${formatdate("YYYYMMDD-hhmm", timestamp())}"
  instance_type = var.instance_type
  region        = var.aws_region
  source_ami    = data.amazon-ami.amazon_linux.id
  ssh_username  = "ec2-user"
  shutdown_behavior = "stop"

  # IAM instance profile (required for Packer to access AWS services)
  iam_instance_profile = var.iam_instance_profile != "" ? var.iam_instance_profile : null

  # VPC and subnet configuration (optional - if not specified, uses default VPC)
  vpc_id    = var.vpc_id != "" ? var.vpc_id : null
  subnet_id = var.subnet_id != "" ? var.subnet_id : null

  # Security group (will be created automatically if not specified)
  # security_group_ids = ["sg-xxxxxxxxx"]

  # AMI tags
  ami_description = "AMI with Nginx web server pre-installed and pre-configured"
  tags = {
    Name        = "${var.project_name}-${var.ami_name}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Packer"
    CreatedAt   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  }

  # Snapshot tags
  snapshot_tags = {
    Name        = "${var.project_name}-${var.ami_name}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Packer"
  }
}

# Build steps
build {
  name = "nginx-ami-build"
  sources = [
    "source.amazon-ebs.nginx"
  ]

  # Update system packages and install Nginx and AWS CLI
  provisioner "shell" {
    inline = [
      "set -e",
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y nginx1",
      "sudo yum install -y aws-cli",
      "sudo systemctl enable nginx"
    ]
  }

  # Copy base nginx configuration
  provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/nginx.conf"
  }

  # Install base nginx configuration
  provisioner "shell" {
    inline = [
      "set -e",
      "sudo mkdir -p /etc/nginx/conf.d",
      "sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf",
      "sudo chown root:root /etc/nginx/nginx.conf",
      "sudo chmod 644 /etc/nginx/nginx.conf"
    ]
  }

  # Copy default index.html
  provisioner "file" {
    source      = "templates/index.html"
    destination = "/tmp/index.html"
  }

  # Install default index.html
  provisioner "shell" {
    inline = [
      "set -e",
      "sudo mkdir -p /usr/share/nginx/html",
      "sudo mv /tmp/index.html /usr/share/nginx/html/index.html",
      "sudo chown nginx:nginx /usr/share/nginx/html/index.html",
      "sudo chmod 644 /usr/share/nginx/html/index.html"
    ]
  }


  # Clean up and prepare for AMI
  provisioner "shell" {
    inline = [
      "set -e",
      "sudo rm -rf /tmp/*",
      "sudo yum clean all",
      "sudo rm -rf /var/cache/yum",
      "sudo cloud-init clean",
      "# Clear shell history for security",
      "history -c",
      "rm -f ~/.bash_history",
      "rm -f ~/.sh_history",
      "unset HISTFILE"
    ]
  }

  # Post-processor to output AMI ID
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
  }
}
