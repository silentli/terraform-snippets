####
# S3 Backend Module Variables
####

variable "bucket_name" {
  description = "Name of S3 bucket for Terraform state (must be globally unique)"
  type        = string
}

variable "allowed_role_arns" {
  description = "List of IAM role ARNs allowed to access the bucket"
  type        = list(string)
  default     = []
}
