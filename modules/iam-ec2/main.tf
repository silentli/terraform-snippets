# IAM - EC2 Instance Role and Profile

# Trust policy for EC2 instances
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# IAM Role for EC2 instances
resource "aws_iam_role" "ec2" {
  name               = "${var.project_name}-ec2-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-ec2-role-${var.environment}"
    }
  )
}

# Attach AWS managed policies if enabled
resource "aws_iam_role_policy_attachment" "managed" {
  for_each = var.enable_managed_policies ? var.policy_arns : {}

  role       = aws_iam_role.ec2.name
  policy_arn = each.value
}

# Create customer-managed policies if enabled
resource "aws_iam_policy" "custom" {
  for_each = var.enable_custom_policies ? var.policies : {}

  name        = "${var.project_name}-${each.key}-${var.environment}"
  description = "Custom IAM policy for ${each.key}"
  # Policy is already a JSON string (enforced by variable type and validation)
  policy = each.value

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${each.key}-policy-${var.environment}"
    }
  )
}

# Attach customer-managed policies to role
resource "aws_iam_role_policy_attachment" "custom" {
  for_each = var.enable_custom_policies ? var.policies : {}

  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.custom[each.key].arn
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-${var.environment}"
  role = aws_iam_role.ec2.name

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-ec2-profile-${var.environment}"
    }
  )
}
