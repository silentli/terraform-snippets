# Bootstrap Infrastructure
terraform {
  backend "local" {}
}

# OIDC Provider
module "oidc" {
  source = "../modules/oidc"
  
  common_tags = local.common_tags
}

# IAM Roles (Bootstrap in iam-roles.tf, Network/Compute in modules)
module "iam_network" {
  source            = "../modules/iam-network"
  project_name      = var.project_name
  environment       = var.environment
  github_org        = var.github_org
  github_repo       = var.github_repo
  oidc_provider_arn = module.oidc.oidc_provider_arn
  common_tags       = local.common_tags
}

module "iam_compute" {
  source            = "../modules/iam-compute"
  project_name      = var.project_name
  environment       = var.environment
  github_org        = var.github_org
  github_repo       = var.github_repo
  oidc_provider_arn = module.oidc.oidc_provider_arn
  common_tags       = local.common_tags
}

# S3 Backend
module "s3_backend" {
  source = "../modules/s3-backend"

  bucket_name        = var.bucket_name
  allowed_role_arns = [
    aws_iam_role.terraform_bootstrap.arn,
    module.iam_network.terraform_network_role_arn,
    module.iam_compute.terraform_compute_role_arn
  ]
  common_tags = local.common_tags
}
