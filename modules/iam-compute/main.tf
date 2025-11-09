# IAM - Compute Layer


data "aws_iam_policy_document" "oidc_assume_role" {
  statement {
    effect = "Allow"
    principal {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
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

data "aws_iam_policy_document" "terraform_compute" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeInstances",
      "ec2:DescribeImages",
      "ec2:DescribeKeyPairs",
      "ec2:CreateKeyPair",
      "ec2:DeleteKeyPair",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags",
      "ec2:ModifyInstanceAttribute",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:CreateVolume",
      "ec2:DeleteVolume",
      "ec2:DescribeVolumes",
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
      "ec2:DescribeSnapshots",
      "rds:CreateDBInstance",
      "rds:DeleteDBInstance",
      "rds:DescribeDBInstances",
      "rds:ModifyDBInstance",
      "rds:CreateDBSubnetGroup",
      "rds:DeleteDBSubnetGroup",
      "rds:DescribeDBSubnetGroups",
      "rds:CreateDBParameterGroup",
      "rds:DeleteDBParameterGroup",
      "rds:DescribeDBParameterGroups",
      "rds:ModifyDBParameterGroup",
      "lambda:CreateFunction",
      "lambda:DeleteFunction",
      "lambda:GetFunction",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
      "lambda:ListFunctions",
      "lambda:AddPermission",
      "lambda:RemovePermission",
      "lambda:GetPolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "terraform_compute" {
  name               = "${var.project_name}-terraform-compute-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role.json

  tags = merge(
    var.common_tags,
    {
      Name = "terraform-compute-role"
    }
  )
}

resource "aws_iam_policy" "terraform_compute" {
  name        = "${var.project_name}-terraform-compute-${var.environment}"
  description = "Policy for Terraform compute operations"
  policy      = data.aws_iam_policy_document.terraform_compute.json

  tags = merge(
    var.common_tags,
    {
      Name = "terraform-compute-policy"
    }
  )
}

resource "aws_iam_role_policy_attachment" "terraform_compute" {
  role       = aws_iam_role.terraform_compute.name
  policy_arn = aws_iam_policy.terraform_compute.arn
}
