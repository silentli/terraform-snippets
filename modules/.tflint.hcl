# Module-specific TFLint config
# Modules inherit root config but relax version requirements

extends = ["../.tflint.hcl"]

rule "terraform_required_version" {
  enabled = false
}

rule "terraform_required_providers" {
  enabled = false
}
