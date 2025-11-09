# Bootstrap IAM Role and Policy

# OIDC assume role policy
data "aws_iam_policy_document" "oidc_assume_role" {
  statement {
    effect = "Allow"
    principal {
      type        = "Federated"
      identifiers = [module.oidc.oidc_provider_arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_org}/${var.github_repo}:ref:refs/heads/*"]
    }
  }
}

# Bootstrap policy
data "aws_iam_policy_document" "terraform_bootstrap" {
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetBucketEncryption",
      "s3:PutBucketEncryption",
      "s3:GetBucketPublicAccessBlock",
      "s3:PutBucketPublicAccessBlock",
      "s3:GetBucketOwnershipControls",
      "s3:PutBucketOwnershipControls",
      "s3:ListBucket",
      "s3:GetBucketPolicy",
      "s3:PutBucketPolicy",
      "s3:DeleteBucketPolicy"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
  
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:CreateOpenIDConnectProvider",
      "iam:DeleteOpenIDConnectProvider",
      "iam:GetOpenIDConnectProvider",
      "iam:ListOpenIDConnectProviders",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:TagPolicy",
      "iam:UntagPolicy"
    ]
    resources = ["*"]
  }
}

# Bootstrap role
resource "aws_iam_role" "terraform_bootstrap" {
  name = "${var.project_name}-terraform-bootstrap-${var.environment}"

  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "terraform-bootstrap-role"
    }
  )
}

# Bootstrap policy
resource "aws_iam_policy" "terraform_bootstrap" {
  name        = "${var.project_name}-terraform-bootstrap-${var.environment}"
  description = "Policy for Terraform bootstrap operations"

  policy = data.aws_iam_policy_document.terraform_bootstrap.json

}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "terraform_bootstrap" {
  role       = aws_iam_role.terraform_bootstrap.name
  policy_arn = aws_iam_policy.terraform_bootstrap.arn
}
