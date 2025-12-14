####
# Terraform Backend Configuration Template
####
# This is a template file for creating backend configurations
# Copy this file to the new layer and update the key path

terraform {
  backend "s3" {
    bucket  = "${bucket}"
    key     = "${key}"
    region  = "${region}"
    encrypt = true
  }
}
