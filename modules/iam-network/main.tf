# IAM - Network Layer


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

data "aws_iam_policy_document" "terraform_network" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeVpcs",
      "ec2:ModifyVpcAttribute",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DescribeSubnets",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DescribeInternetGateways",
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:CreateRouteTable",
      "ec2:DeleteRouteTable",
      "ec2:DescribeRouteTables",
      "ec2:CreateRoute",
      "ec2:DeleteRoute",
      "ec2:AssociateRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateNatGateway",
      "ec2:DeleteNatGateway",
      "ec2:DescribeNatGateways",
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:DescribeAddresses",
      "ec2:CreateNetworkAcl",
      "ec2:DeleteNetworkAcl",
      "ec2:DescribeNetworkAcls",
      "ec2:CreateNetworkAclEntry",
      "ec2:DeleteNetworkAclEntry",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:ReplaceNetworkAclAssociation"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "terraform_network" {
  name               = "${var.project_name}-terraform-network-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role.json

  tags = {
    Name = "terraform-network-role"
  }
}

resource "aws_iam_policy" "terraform_network" {
  name        = "${var.project_name}-terraform-network-${var.environment}"
  description = "Policy for Terraform network operations"
  policy      = data.aws_iam_policy_document.terraform_network.json

  tags = {
    Name = "terraform-network-policy"
  }
}

resource "aws_iam_role_policy_attachment" "terraform_network" {
  role       = aws_iam_role.terraform_network.name
  policy_arn = aws_iam_policy.terraform_network.arn
}
