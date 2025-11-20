# Common Tags
# Note: common_tags is kept for future use when additional cost governance resources are added
locals {
  common_tags = merge( # tflint-ignore: terraform_unused_declarations
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.additional_tags
  )
}
